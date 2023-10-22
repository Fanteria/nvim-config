local ibl_ok, ibl = pcall(require, "ibl")
if not ibl_ok then
  print("indent-blankline failed")
  return
end

local enabled = true
ibl.setup({
  enabled = enabled,
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
})

function ToggleWhitespaces()
  print(vim.inspect(ibl.config))
  if enabled then
    ibl.update({ enabled = false })
    vim.cmd("tabdo windo set list")
  else
    ibl.update({ enabled = true })
    vim.cmd("tabdo windo set nolist")
  end
  enabled = not enabled
end
