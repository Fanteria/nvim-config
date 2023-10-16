local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
  print("Nvim tree cannot be loaded.")
  return
end

nvim_tree.setup({
  disable_netrw = true, -- completely disable vim's file explorer
  sync_root_with_cwd = true,
  diagnostics = {
    enable = true,
  },
  update_focused_file = { -- un-collapse until find file
  enable = true,
  update_cwd = true,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 2000,
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false,
      },
    },
  },
  on_attach = function(bufnr)
    local opts =  function(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    local node = require("nvim-tree.api").node
    local map = vim.keymap.set

    map('n', 'l', node.open.edit, opts('Open'))
    map('n', '<CR>', node.open.edit, opts('Open'))
    map('n', 'o', node.open.edit, opts('Open'))
    map('n', 'h', node.navigate.parent_close, opts('Close Directory'))
    map('n', 'v', node.open.vertical, opts('Open: Vertical Split'))
  end,
})
