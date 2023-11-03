# Neovim configuration

This is my personal Neovim configuration. It provides an overview of my setup and the plugins I use in Neovim. This configuration is designed to automate the setup process and enhance my Neovim experience.

It includes various plugins, such as Lazy.nvim, Treesitter, LSP support, completions, snippets, utilities, and more.

## Installation

The installation of Neovim configuration is automated. Upon the first run, the necessary plugins and dependencies will be installed automatically. Lazy.nvim easily manage this process.

Here are the steps for the initial setup:

1. Clone my Neovim configuration repository to my machine.
2. Launch Neovim.
3. On the first run, the necessary plugins and dependencies will be installed automatically.

To install an additional spell check language, follow these steps:

1. Uncomment the line `disable_netrw = true` in the `nvim-tree.lua` configuration file. This line is responsible for completely disabling Vim's file explorer, which is temporarily required for the spell check installation.
2. Restart Neovim to automatically install new language.
3. After successfully installing the additional spell check language, revert the changes in the `nvim-tree.lua` configuration file.
4. Again restart Neovim.
5. Run the `checkhealth` command to ensure a healthy Neovim installation. 

## Plugins

### Essential

##### Lazy.nvim

[Lazy.nvim](https://github.com/folke/lazy.nvim) is plugin manager. It automates the installation of other plugins and manages their updates, ensuring a smooth setup process for my Neovim configuration.

##### Treesitter

[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) is a powerful parsing system for Neovim, providing syntax highlighting, code folding, and more. Enhanced with additional plugin as [Treesitter context](https://github.com/nvim-treesitter/nvim-treesitter-context).

##### LSP (Language Server Protocol)

- [Mason.nvim](https://github.com/williamboman/mason.nvim): Integrates the Language Server Protocol (LSP) with my Neovim setup.
- [Mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): A configuration extension for Mason.nvim.
- [Nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Provides configurations for various language servers.

##### Completions

- [Nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A powerful completion framework for Neovim.
- Cmp-buffer, Cmp-path, Cmp-cmdline, Cmp-nvim-lsp: Completions for buffers, paths, cmdline, and LSP. All from [hrsh7th](https://github.com/hrsh7th).

##### Snippets

[LuaSnip](https://github.com/L3MON4D3/LuaSnip) is my chosen snippet engine for Neovim. It enhances code generation and editing efficiency.

### Utilities

- [Which-key.nvim](https://github.com/folke/which-key.nvim): A plugin for keybinding visualization and management.
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A highly extensible fuzzy finder.
- [Sessions.nvim](https://github.com/natecraddock/sessions.nvim): Manages session persistence in Neovim.
- [Hop.nvim](https://github.com/phaazon/hop.nvim): Fast cursor movement plugin.
- [Nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua): A file system navigator for Neovim.
- [Nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): Provides icons for Nvim-tree.
- [Neogen](https://github.com/danymat/neogen): Code generation using Treesitter.
- [Nvim-autopairs](https://github.com/windwp/nvim-autopairs): Automatic bracket and pair completion.
- [Comment.nvim](https://github.com/numToStr/Comment.nvim): Enhanced code commenting support.
- [Treesitter Playground](https://github.com/nvim-treesitter/playground): Provides a amazing playground for Treesitter.
- [Vim-bbye](https://github.com/moll/vim-bbye): A plugin to delete buffers.
- [Coverage](https://github.com/andythigpen/nvim-coverage): A plugin to show code coverage results.

##### Git

- [Gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) enhances my Git integration in Neovim by providing Git status indicators.
- [Fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper for vim.

### Debugging

- [nvim-dap](https://github.com/mfussenegger/nvim-dap): A debugging adapter protocol for Neovim.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): A user interface for debugging in Neovim.

### Visual

- [Lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A fast and configurable status line.
- [Indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim): Displays indent guides in my code.
- [Nvim-ufo](https://github.com/kevinhwang91/nvim-ufo): A plugin for managing asynchronous tasks and promises.
- [Material.nvim](https://github.com/marko-cerovac/material.nvim): A colorful and vibrant colorscheme for Neovim.
- [Alpha-nvim](https://github.com/goolord/alpha-nvim): Provides an extensible, customizable startup page.
- [Project.nvim](https://github.com/ahmedkhalf/project.nvim): A Telescope extension that manages projects and directories in Neovim.

### Optional Plugins

I can't choose to add these plugins, but they can be very useful:

- [vim-symlink](https://github.com/aymericbeaumet/vim-symlink): Automatically follows symlinks.
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim): Enables using buffers as tabs.
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim): Provides a terminal toggle.
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim): Enables Markdown preview.

## Conclusion

Feel free to explore and adapt this Neovim configuration to your needs. If you encounter any bugs or have suggestions for improvements, please consider opening an issue or a merge request on the GitHub repository. Your input is valuable and will help in refining my Neovim configuration.
