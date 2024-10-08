local M = {}

--- Setup signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

--- Setup function.
function M.setup()
  local lsp_defaults = require("lspconfig").util.default_config

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  -- Setup LISP defaults
  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local opts = { noremap = true, silent = true, buffer = event.buf }
      local map = vim.keymap.set
      local telescope = require("telescope.builtin")

      map('n', 'K', vim.lsp.buf.hover, opts)
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', 'gSd', function() telescope.lsp_definitions({ jump_type = "split" }) end, opts)
      map('n', 'gsd', function() telescope.lsp_definitions({ jump_type = "vsplit" }) end, opts)
      map('n', 'gD', vim.lsp.buf.declaration, opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', 'go', vim.lsp.buf.type_definition, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', 'gR', telescope.lsp_references, opts)
      map('n', 'gs', vim.lsp.buf.signature_help, opts)
      map('n', '<leader>r', vim.lsp.buf.rename, opts)
      -- map({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
      map('n', '<leader>a', vim.lsp.buf.code_action, opts)
      map('n', 'ga', vim.lsp.buf.code_action, opts)
      map('n', 'gl', vim.diagnostic.open_float, opts)
      map('n', '[d', vim.diagnostic.goto_prev, opts)
      map('n', ']d', vim.diagnostic.goto_next, opts)
    end
  })
end

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>L", group = "LSP" },
  {
    "<leader>Ld",
    fn("telescope", function(t) t.diagnostics() end),
    desc = "Diagnostics",
  },
  {
    "<leader>Li",
    "<cmd>LspInfo<cr>",
    desc = "Info"
  },
  {
    "<leader>LI",
    "<cmd>Mason<cr>",
    desc = "Installer Info"
  },
  {
    "<leader>Ll",
    vim.lsp.codelens.run,
    desc = "CodeLens Action"
  },
  {
    "<leader>Lq",
    vim.lsp.diagnostic.set_loclist,
    desc = "Quickfix"
  },
  {
    "<leader>Lp",
    "<cmd>TSPlaygroundToggle<CR>",
    desc = "Treesitter playground"
  },
  {
    "<leader>Ls",
    fn("telescope", function(t) t.lsp_document_symbols() end),
    desc = "Document Symbols"
  },
  {
    "<leader>LS",
    fn("telescope", function(t) t.lsp_dynamic_workspace_symbols() end),
    desc = "Workspace Symbols",
  },
}

return M
