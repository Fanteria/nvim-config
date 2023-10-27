local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local default_setup = function(server)
  require("lspconfig")[server].setup({
    capabilities = capabilities,
  })
end

M.opts = {
  ensure_installed = { "lua_ls", "clangd", "bashls", "rust_analyzer" },
  handlers = {
    default_setup,
    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
    clangd = function()
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
        settings = {
          clangd = {
            arguments = { "--std=c++17" },
          },
        },
      })
    end
  },
}

return M
