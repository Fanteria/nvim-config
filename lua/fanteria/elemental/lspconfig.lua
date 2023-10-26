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

-- Setup LISP defaults
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', { -- TODO check nim_create_Autocad
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
--       --     vim.env.VIM RUN TIME,
--       --   }
--       -- }
--     }
--   }
-- })
