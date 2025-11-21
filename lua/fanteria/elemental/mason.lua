local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Mason options - only handles installation now
M.opts = {
  ensure_installed = {
    "lua_ls",
    "clangd",
    "bashls",
    "rust_analyzer",
    "gopls",
  },
}

function M.setup(_, opts)
  require("mason-lspconfig").setup(opts)
  -- Configure servers AFTER mason-lspconfig setup

  -- Configure lua_ls
  vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            -- Add more paths if needed
            -- "${3rd}/luv/library",
          },
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  -- Configure rust_analyzer
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy"
        }
      },
    },
  })

end

return M
