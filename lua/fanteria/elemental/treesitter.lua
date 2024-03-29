local M = {}

M.opts = {
  ensure_installed = "all",
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = function ()
      return vim.g.is_large_buffer -- this variable is set in auto BufReadPre auto command
    end,
  },
  incremental_celection = {
    enable = false,
    disable = { "" },
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "" },
  },
  playground = {
    enable = true,
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

return M
