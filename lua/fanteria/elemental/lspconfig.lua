local M = {}

-- Setup signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

M.setup = function ()
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
      local opts = { buffer = event.buf }
      local telescope = require("telescope.builtin")

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gsd', function() telescope.lsp_definitions({jump_type="split"}) end, opts)
      vim.keymap.set('n', 'gvd', function() telescope.lsp_definitions({jump_type="vsplit"}) end, opts)

      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gR', telescope.lsp_references, opts)
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'x' }, '<leader>f', function () vim.lsp.buf.format({async = true}) end, opts)
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end
  })
end

return M
