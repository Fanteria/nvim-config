local M = {}

M.get_bufs = function()
  local loaded = {}
  for _, buf in pairs(vim.split(vim.fn.execute("buffers"), "\n")) do
    if string.len(buf) ~= 0 then
      loaded[tonumber(string.match(buf, "%d+"))] = buf
    end
  end
  return loaded
end

M.get_open_bufs = function()
  local aux = {}
  for _, win in pairs(vim.api.nvim_list_wins()) do
    aux[vim.api.nvim_win_get_buf(win)] = win
  end
  return aux
end

M.telescope_buffers_in_tabs = function (opts)
	opts = opts or {}
	local buffers = {}
  local buffers_data = {}

  local all = M.get_bufs()
  -- vim.notify(vim.inspect(buffers_data))
  -- vim.notify(vim.inspect(all))
  for bufrn, winrn in pairs(M.get_open_bufs()) do
      buffers_data[all[bufrn]] = {
        win = winrn,
        tab = vim.api.nvim_win_get_tabpage(winrn),
      }
	    table.insert(buffers, all[bufrn])
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config")
  local actions = require("telescope.actions")
  local pickers = require("telescope.pickers")
  local action_state = require("telescope.actions.state")
	pickers
		.new(opts, {
			prompt_title = "Buffers in tabs",
			finder = finders.new_table({ results = buffers }),
			sorter = conf.values.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					-- local selection = action_state.get_selected_entry()[1]
          local selected = buffers_data[action_state.get_selected_entry()[1]]
          vim.notify(vim.inspect(selected))
          -- vim.api.nvim_tabpage_goto(selected.tab)
          vim.cmd.tabnext(selected.tab)
          vim.api.nvim_set_current_win(selected.win)
          -- vim.cmd(":wincmd " .. selected.winrn)

				end)
				return true
			end,
		})
		:find()
end

M.close_not_open_bufs = function()
  local open = M.get_open_bufs()
  for bufnr, _ in pairs(M.get_bufs()) do
    if not open[bufnr] then
      vim.cmd("Bdelete " .. bufnr)
    end
  end
end

M.notify = function(msg, lvl)
  local level
  if lvl == vim.log.levels.ERROR then
    level = "critical"
  elseif lvl == vim.log.levels.WARN then
    level = "normal"
  else
    level = "low"
  end
  local Job = require("plenary.job")
  Job:new({command = "notify-send", args = { "-i", "/home/jirka/Neovim-mark.svg.png", "-u", level, "Neovim", msg} }):start()
end

-- Function to customize folded text
function FoldText()
  local start_line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local end_line = vim.fn.getline(vim.v.foldend)
  return start_line .. " ... " .. line_count .. " lines ... " .. end_line
end

return M

