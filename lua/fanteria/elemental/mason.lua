local mason_ok, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not mason_ok or not mason_lspconfig_ok or not lspconfig_ok then
  print("Mason cannot be loaded.")
  return
end

mason.setup()

local default_setup = function(server)
  lspconfig[server].setup({})
end

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "clangd", "bashls", "rust_analyzer" },
  handlers = {
    default_setup,
    lua_ls = function()
      lspconfig.lua_ls.setup({
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
    clangd = function ()
      lspconfig.clangd.setup({
        settings = {
          clangd = {
            arguments = { "--std=c++17" },
          },
        },
      })
    end
  },
})
