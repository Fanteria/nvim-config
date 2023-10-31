local M = {}

M.get_loaded_bufs = function()
  local loaded = {}
  for _, buf in ipairs(vim.split(vim.fn.execute("buffers"), "\n")) do
    if string.len(buf) ~= 0 then
      loaded[tonumber(string.match(buf, "%d+"))] = buf
    end
  end
  return loaded
end

M.get_open_bufs = function()
  local aux = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    aux[vim.api.nvim_win_get_buf(win)] = true
  end
  return aux
end

M.close_not_open_bufs = function()
  local open = M.get_open_bufs()
  for bufnr, _ in ipairs(M.get_loaded_bufs()) do
    print(open[bufnr])
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

return M
