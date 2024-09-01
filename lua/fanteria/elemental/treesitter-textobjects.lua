local M = {}

--- Treesitter text objects options.
M.opts = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
      ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
      ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
      ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
      ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
      ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
    },
    include_surrounding_whitespace = false,
  },
  swap = {
    enable = true,
    swap_next = {
      ["<C-s>a"] = "@parameter.inner",
      ["<C-s>f"] = "@function.outer", -- does not move doc comment
    },
    swap_previous = {
      ["<C-s>A"] = "@parameter.inner",
      ["<C-s>F"] = "@function.outer", -- does not move doc comment
    }
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]c"] = "@class.outer",
      ["]a"] = "@parameter.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]C"] = "@class.outer",
      ["]A"] = "@parameter.outer",
    },
    goto_prev_start = {
      ["[m"] = "@function.outer",
      ["[c"] = "@class.outer",
      ["[a"] = "@parameter.outer",
    },
    goto_prev_end = {
      ["[M"] = "@function.outer",
      ["[C"] = "@class.outer",
      ["[A"] = "@parameter.outer",
    }
  },
  lsp_interop = {
    enable = true,
    floating_preview_opts = { border = "none" },
    peek_definition_code = {
      ["gp"] = "@function.outer",
      ["gP"] = "@class.outer",
    },
  },
}

return M
