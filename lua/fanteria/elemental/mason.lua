local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

--- Default setup for server.
---@param server string Server name.
local function default_setup(server)
  require("lspconfig")[server].setup({
    capabilities = capabilities,
  })
end

-- For `bashls` must be installed shellcheck on system.
--- Mason options.
M.opts = {
  ensure_installed = {
    "lua_ls",
    "clangd",
    "bashls",
    "rust_analyzer",
    "harper_ls",
    "gopls",
  },
  handlers = {
    default_setup,
    lua_ls = function()
      require("lspconfig").lua_ls.setup(M.server_opts.lua_ls)
    end,
    rust_analyzer = function()
      require("lspconfig").rust_analyzer.setup(M.server_opts.rust_analyzer)
    end,
    harper_ls = function()
      require("lspconfig").harper_ls.setup(M.server_opts.harper_ls)
    end,
  },
}

--- Options for servers.
M.server_opts = {
  lua_ls = {
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
  },
  rust_analyzer = {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy"
        }
      },
    },
  },
  harper_ls = {
    capabilities = capabilities,
    autostart = false,
  }
}

return M
