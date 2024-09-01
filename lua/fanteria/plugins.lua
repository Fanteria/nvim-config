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
    opts = require("fanteria.elemental.treesitter").opts,
    setup = require("fanteria.elemental.treesitter").setup,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = require("fanteria.elemental.treesitter-context").opts,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = require("fanteria.elemental.mason").opts,
  },
  {
    "neovim/nvim-lspconfig",
    version = false,
    config = require("fanteria.elemental.lspconfig").setup,
  },
  {
    'stevearc/conform.nvim',
    opts = require("fanteria.elemental.conform").opts,
  },

  -- Completions
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",  -- buffer completions
      "hrsh7th/cmp-path",    -- path completions
      "hrsh7th/cmp-cmdline", -- cmdline completions
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = require("fanteria.elemental.cmp").opts,
    config = require("fanteria.elemental.cmp").setup,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    opts = require("fanteria.elemental.luasnip").opts,
  },

  -- Utilities --
  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = require("fanteria.utils.which-key").opts,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- extension like undotree
      "debugloop/telescope-undo.nvim",
      -- vim select options are delegated to telescope
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = require("fanteria.utils.telescope").opts,
    config = require("fanteria.utils.telescope").setup,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    config = true,
  },
  {
    "kyazdani42/nvim-tree.lua", -- file system for vim
    opts = require("fanteria.utils.nvim-tree").opts,
  },
  {
    "kyazdani42/nvim-web-devicons", -- icons for nvim-tree
    opts = require("fanteria.visual.web-devicons").opts
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*",
    opts = require("fanteria.utils.neogen").opts,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = require("fanteria.utils.autopairs").opts,
    config = require("fanteria.utils.autopairs").setup,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = true,
    -- This plugin add few mappings
    -- gcc to comment act line with line comment
    -- gbc to comment act line with block comment
    -- gc  to comment visual block with line comment
    -- gb  to comment visual block with block comment
    -- gcA to add line comment on the end of the line
  },
  {
    'nvim-treesitter/playground',
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  "moll/vim-bbye",
  {
    "folke/trouble.nvim",
    opts = require("fanteria.utils.trouble").opts,
    cmd = "Trouble",
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    opts = require("fanteria.visual.gitsigns").opts,
  },
  "tpope/vim-fugitive",

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = require("fanteria.utils.dap").setup,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = require("fanteria.utils.dapui").setup,
  },

  -- Code coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    opts = require("fanteria.utils.nvim-coverage").opts,
  },

  -- Visual --
  "RRethy/vim-illuminate",
  {
    "nvim-lualine/lualine.nvim",
    opts = require("fanteria.visual.lualine").opts
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = require("fanteria.visual.indent-blankline").opts,
    main = "ibl",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = 'kevinhwang91/promise-async',
  },

  -- Colorscheme
  {
    "marko-cerovac/material.nvim",
    opts = require("fanteria.visual.material").opts,
    config = require("fanteria.visual.material").setup,
  },

  -- Title page
  {
    "goolord/alpha-nvim",
    config = require("fanteria.title.alpha").setup,
  },
  "ahmedkhalf/project.nvim",

  -- LLM
  {
    "David-Kunz/gen.nvim",
    opts = require("fanteria.utils.gen").opts,
    config = require("fanteria.utils.gen").setup
  },

  -- this plugin automatically follow symlinks if are opened
  -- I use it to auto follow from `include` directories
  -- "aymericbeaumet/vim-symlink"
  --
  -- this plugin enables use buffers as tabs in ordinary editors
  -- "akinsho/bufferline.nvim",
  --
  -- "akinsho/toggleterm.nvim",

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = require("fanteria.utils.markdown-preview").setup,
  },

  -- C++ implementation generator
  {
    'eriks47/generate.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  }
}, {})
