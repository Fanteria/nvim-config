local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  print("Lspconfig cannot be loaded.")
  return
end
local lsp_defaults = lspconfig.util.default_config

-- Setup signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Setup LSP defaults
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', { -- TODO check nvim_create_autocmd
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  end
})

-- require('mason-lspconfig').setup_handlers {
--   function(server_name)    -- default handler (optional)
--     require("lspconfig")[server_name].setup {}
--   end,
--   -- Next, you can provide a dedicated handler for specific servers.
--   -- For example, a handler override for the `rust_analyzer`:
--   -- ["rust_analyzer"] = function ()
--   --     require("rust-tools").setup {}
--   -- end
--   -- ["clangd"] = function()
--   --   require("lspconfig").clangd.setup({
--   --     settings = {
--   --     },
--   --   })
--   -- end,
--   ["lua_ls"] = function()
--     require("lspconfig").lua_ls.setup({
--       settings = {
--         Lua = {
--           runtime = {
--             version = 'LuaJIT'
--           },
--           diagnostics = {
--             globals = { "vim" },
--           },
--         },
--       },
--     })
--   end,
-- }

-- require'lspconfig'.lua_ls.setup {
--   on_init = function(client)
--     print("HELLO")
--     local path = client.workspace_folders[1].name
--     if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
--       client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
--         Lua = {
--           runtime = {
--             -- Tell the language server which version of Lua you're using
--             -- (most likely LuaJIT in the case of Neovim)
--             version = 'LuaJIT'
--           },
--           diagnostics = {
--             globals = { "vim" },
--           },
--           -- Make the server aware of Neovim runtime files
--           workspace = {
--             checkThirdParty = false,
--             library = {
--               vim.env.VIMRUNTIME
--               -- "${3rd}/luv/library"
--               -- "${3rd}/busted/library",
--             }
--             -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
--             -- library = vim.api.nvim_get_runtime_file("", true)
--           }
--         }
--       })
--
--       client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--       end
--     print("hello")
--     return true
--   end
-- }

-- require("lspconfig").lua_ls.setup({
--   settings = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
--   },
-- })

-- local lspconfig = require("lspconfig")
-- local opts = {
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 					[vim.fn.stdpath("config") .. "/lua"] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
-- lspconfig.lua_ls.setup(opts)

-- require('lspconfig').lua_ls.setup({
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT'
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       -- workspace = {
--       --   library = {
--       --     vim.env.VIMRUNTIME,
--       --   }
--       -- }
--     }
--   }
-- })
