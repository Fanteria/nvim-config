local fn = vim.fn

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  -- Automatically install packer -- stolen from LunarVim https://github.com/LunarVim/Neovim-from-scratch
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
  end
  return
end

-- packer.init({
--   display = {
--     open_fn = function() 
--       require("packer.util").float({border = "rounded"})
--     end,
--   },
-- })

return packer.startup(function(use)
  -- Basic
  use("wbthomason/packer.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  -- Essential
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-telescope/telescope.nvim")

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/mason.nvim") -- simple to use language server installer
  use("williamboman/mason-lspconfig.nvim")
  -- use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  -- use("RRethy/vim-illuminate")

  -- Nice to have
  use({ "jiaoshijie/undotree", requires = "nvim-lua/plenary.nvim" })
  use("natecraddock/sessions.nvim") -- TODO Is this plugin really nessesary?
  use({'phaazon/hop.nvim', branch = 'v2' })
  use("kyazdani42/nvim-tree.lua") -- file system for vim

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Colorscheme
  use("marko-cerovac/material.nvim")

  -- Debugging

  -- Visual
  use("nvim-lualine/lualine.nvim")
  use("akinsho/bufferline.nvim")
  use("lukas-reineke/indent-blankline.nvim")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  --[[ use("rafamadriz/friendly-snippets") -- a bunch of snippets to use ]]

  -- cmp plugins
  -- use("hrsh7th/nvim-cmp") -- The completion plugin
  -- use("hrsh7th/cmp-buffer") -- buffer completions
  -- use("hrsh7th/cmp-path") -- path completions
  -- use("hrsh7th/cmp-cmdline") -- cmdline completions
  -- use("saadparwaiz1/cmp_luasnip") -- snippet completions
  -- use("hrsh7th/cmp-nvim-lsp")

  -- use("windwp/nvim-autopairs")
  -- use("numToStr/Comment.nvim")
  -- use("kyazdani42/nvim-web-devicons")
  -- use("moll/vim-bbye")
  -- use("nvim-lualine/lualine.nvim")
  -- use("akinsho/toggleterm.nvim")
  -- use("ahmedkhalf/project.nvim")
  -- use("lewis6991/impatient.nvim")
  -- use("lukas-reineke/indent-blankline.nvim")
  -- use("goolord/alpha-nvim")
  -- use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  -- use("folke/which-key.nvim")

  -- markdown preview
  -- use({
  --   "iamcco/markdown-preview.nvim",
  --   run = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- })
end)
