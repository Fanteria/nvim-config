local M = {}

M.enabled = true

--- Toggles whitespace visibility in all windows of the current tab.
function M.toggle_whitespaces()
  local ibl = require("ibl")
  local tabpage = vim.api.nvim_get_current_tabpage()
  local win = vim.api.nvim_get_current_win()
  if M.enabled then
    ibl.update({ enabled = false })
    vim.cmd("tabdo windo set list")
  else
    ibl.update({ enabled = true })
    vim.cmd("tabdo windo set nolist")
  end
  vim.api.nvim_set_current_tabpage(tabpage)
  vim.api.nvim_set_current_win(win)
  M.enabled = not M.enabled
end

--- Indent blank line options.
M.opts = {
  enabled = M.enabled,
  indent = {
    char = "▏",
    smart_indent_cap = true,
  },
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "packer",
      "NvimTree",
    },
    buftypes = {
      "terminal",
      "nofile",
    },
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
}

return M
