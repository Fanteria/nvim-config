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

-- Helper function
local function parse_line(pos, line, query, tree, result)
  local line_pos = 0

  local prev_range = nil

  for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == pos - 1 and end_row == pos - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, "@" .. name }
      else
        table.insert(result, { text, "@" .. name })
      end
      prev_range = range
    end
  end
end

-- Function to customize folded text
function HighlightedFoldtext()
  local pos = vim.v.foldstart
  local end_pos = vim.v.foldend
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
  local end_line = vim.api.nvim_buf_get_lines(0, end_pos - 1, end_pos, false)[1]

  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, lang)
  local query = vim.treesitter.query.get(parser:lang(), "highlights")

  if query == nil then
    return vim.fn.foldtext()
  end
  local tree = parser:parse({ pos - 1, pos })[1]
  local result = {}

  parse_line(pos, line, query, tree, result)
  local lines_str = string.format("%d", vim.v.foldend - pos + 1) .. " lines"
  table.insert(result, { " ... " .. lines_str .. " ... ", "Folded" })
  parse_line(end_pos, end_line, query, tree, result)

  return result
end

return M

