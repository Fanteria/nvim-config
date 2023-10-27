local M = {}

M.enabled = true

M.toggle_whitespaces = function()
  local ibl = require("ibl")
  print(vim.inspect(ibl.config))
  if M.enabled then
    ibl.update({ enabled = false })
    vim.cmd("tabdo windo set list")
  else
    ibl.update({ enabled = true })
    vim.cmd("tabdo windo set nolist")
  end
  M.enabled = not M.enabled
end


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

M.setup = function(_, opts)
  require("ibl").setup(opts)
end

return M
