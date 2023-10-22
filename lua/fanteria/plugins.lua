local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Basic --
  "wbthomason/packer.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- Essential --
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- LSP
  "neovim/nvim-lspconfig",   -- enable LSP
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim",
  -- "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  -- "RRethy/vim-illuminate",
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- build = "make install_jsregexp"
  },
  --[[ "rafamadriz/friendly-snippets", -- a bunch of snippets to use ]]

  -- completions
  "hrsh7th/nvim-cmp",    -- The completion plugin
  "hrsh7th/cmp-buffer",  -- buffer completions
  "hrsh7th/cmp-path",    -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  -- "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",

  -- Utils --
  "folke/which-key.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim", -- extension like undotree
    },
  },
  "natecraddock/sessions.nvim", -- TODO Is this plugin really nessesary?
  {
    "phaazon/hop.nvim",
    branch = 'v2'
  },
  "kyazdani42/nvim-tree.lua",     -- file system for vim
  "kyazdani42/nvim-web-devicons", -- icons for nvim-tree
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*"
  },
  -- "windwp/nvim-autopairs",
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Debugging

  -- Visual --
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  "lukas-reineke/indent-blankline.nvim",
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
  },
  -- Colorscheme
  "marko-cerovac/material.nvim",


  -- Title page --
  "goolord/alpha-nvim",
  "ahmedkhalf/project.nvim",

  -- "akinsho/toggleterm.nvim",
  -- "lewis6991/impatient.nvim",
  -- markdown preview
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   run = function,
  --     vim.fn["mkdp#util#install"],
  --   end,
  -- },
})
