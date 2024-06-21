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
  incremental_selection = {
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

M.setup = function(_, opts)
  local setup_opts = require'nvim-treesitter.configs'.setup
  for k,v in pairs(opts) do 
    setup_opts[k] = v 
  end
  require("nvim-treesitter.install").compilers = { 'clang' }
end

return M
