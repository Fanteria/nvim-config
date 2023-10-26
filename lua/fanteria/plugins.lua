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
  "williamboman/mason.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
      },
    },
    version = false,
  },
  "RRethy/vim-illuminate",

  -- completions
  -- TODO check validity of all completions
  "hrsh7th/nvim-cmp",    -- The completion plugin
  "hrsh7th/cmp-buffer",  -- buffer completions
  "hrsh7th/cmp-path",    -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- build = "make install_jsregexp"
  },

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
    "smoka7/hop.nvim",
    version = "*",
  },
  "kyazdani42/nvim-tree.lua",     -- file system for vim
  "kyazdani42/nvim-web-devicons", -- icons for nvim-tree
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*"
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
  {
    'nvim-treesitter/playground',
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  "moll/vim-bbye",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Debugging
  -- "mfussenegger/nvim-dap",
  -- { "rcarriga/nvim-dap-ui", dependencies = "mfussenegger/nvim-dap" },

  -- Visual --
  "nvim-lualine/lualine.nvim",
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

  -- this plugin automatically follow symlinks if are opened
  -- I use it to auto follow from `include` directories
  -- "aymericbeaumet/vim-symlink"
  --
  -- this plugin enables use buffers as tabs in ordinary editors
  -- "akinsho/bufferline.nvim",
  --
  -- "akinsho/toggleterm.nvim",
  -- markdown preview
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   run = function,
  --     vim.fn["mkdp#util#install"],
  --   end,
  -- },
}, {})
