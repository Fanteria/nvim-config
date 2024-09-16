local M = {}

--- Nvim-tree options.
M.opts = {
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

    local nvim_tree_api = require("nvim-tree.api")
    local node = nvim_tree_api.node
    local tree = nvim_tree_api.tree
    local fs = nvim_tree_api.fs
    local marks = nvim_tree_api.marks
    local filter = nvim_tree_api.live_filter
    local map = vim.keymap.set

    -- Defaults
    map('n', '<C-]>', tree.change_root_to_node, opts('CD'))
    map('n', '<C-e>', node.open.replace_tree_buffer, opts('Open: In Place'))
    map('n', '<C-k>', node.show_info_popup, opts('Info'))
    map('n', '<C-r>', fs.rename_sub, opts('Rename: Omit Filename'))
    map('n', '<C-t>', node.open.tab, opts('Open: New Tab'))
    map('n', '<C-v>', node.open.vertical, opts('Open: Vertical Split'))
    map('n', '<C-x>', node.open.horizontal, opts('Open: Horizontal Split'))
    map('n', '<BS>', node.navigate.parent_close, opts('Close Directory'))
    map('n', '<CR>', node.open.edit, opts('Open'))
    map('n', '<Tab>', node.open.preview, opts('Open Preview'))
    map('n', '>', node.navigate.sibling.next, opts('Next Sibling'))
    map('n', '<', node.navigate.sibling.prev, opts('Previous Sibling'))
    map('n', '.', node.run.cmd, opts('Run Command'))
    map('n', '-', tree.change_root_to_parent, opts('Up'))
    map('n', 'a', fs.create, opts('Create'))
    map('n', 'bmv', marks.bulk.move, opts('Move Bookmarked'))
    map('n', 'B', tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    map('n', 'c', fs.copy.node, opts('Copy'))
    map('n', 'C', tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    map('n', '[c', node.navigate.git.prev, opts('Prev Git'))
    map('n', ']c', node.navigate.git.next, opts('Next Git'))
    map('n', 'd', fs.remove, opts('Delete'))
    map('n', 'D', fs.trash, opts('Trash'))
    map('n', 'E', tree.expand_all, opts('Expand All'))
    map('n', 'e', fs.rename_basename, opts('Rename: Basename'))
    map('n', ']e', node.navigate.diagnostics.next, opts('Next Diagnostic'))
    map('n', '[e', node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    map('n', 'F', filter.clear, opts('Clean Filter'))
    map('n', 'f', filter.start, opts('Filter'))
    map('n', 'g?', tree.toggle_help, opts('Help'))
    map('n', 'gy', fs.copy.absolute_path, opts('Copy Absolute Path'))
    map('n', 'H', tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    map('n', 'I', tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    map('n', 'J', node.navigate.sibling.last, opts('Last Sibling'))
    map('n', 'K', node.navigate.sibling.first, opts('First Sibling'))
    map('n', 'm', marks.toggle, opts('Toggle Bookmark'))
    map('n', 'o', node.open.edit, opts('Open'))
    map('n', 'O', node.open.no_window_picker, opts('Open: No Window Picker'))
    map('n', 'p', fs.paste, opts('Paste'))
    map('n', 'P', node.navigate.parent, opts('Parent Directory'))
    map('n', 'q', tree.close, opts('Close'))
    map('n', 'r', fs.rename, opts('Rename'))
    map('n', 'R', tree.reload, opts('Refresh'))
    map('n', 's', node.run.system, opts('Run System'))
    map('n', 'S', tree.search_node, opts('Search'))
    map('n', 'U', tree.toggle_custom_filter, opts('Toggle Hidden'))
    map('n', 'W', tree.collapse_all, opts('Collapse'))
    map('n', 'x', fs.cut, opts('Cut'))
    map('n', 'y', fs.copy.filename, opts('Copy Name'))
    map('n', 'Y', fs.copy.relative_path, opts('Copy Relative Path'))
    map('n', '<2-LeftMouse>', node.open.edit, opts('Open'))
    map('n', '<2-RightMouse>', tree.change_root_to_node, opts('CD'))

    -- My options
    map('n', 'l', node.open.edit, opts('Open'))
    map('n', '<CR>', node.open.edit, opts('Open'))
    map('n', 'o', node.open.edit, opts('Open'))
    map('n', 'h', node.navigate.parent_close, opts('Close Directory'))
    map('n', 'v', node.open.vertical, opts('Open: Vertical Split'))
  end,
}

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  {
    "<leader>e",
    fn("nvim-tree.api", function(n) n.tree.toggle() end),
    hidden = true,
  },
}

return M
