local o = vim.opt;

-- Basic
o.backup = false
o.writebackup = false
o.clipboard = "unnamedplus" -- allow to use system clipboard
o.fileencoding = "utf-8"
o.swapfile = false
o.mouse = "a"

o.hidden = true

-- Other
o.completeopt = { "menuone", "noselect" } -- for cmp
o.conceallevel = 0                        -- `` visible in markdown
o.showmode = false                        -- hide `-- INSERT --`, etc.
o.smartcase = true
o.termguicolors = true
o.timeoutlen = 1000 -- time (ms) to wait for keybinds
o.undofile = true
o.updatetime = 300 -- faster completion
o.listchars = "eol:↴,tab: ,trail:~,extends:>,precedes:<,space:·" -- chars that visualize white spaces
o.shortmess:append("c")
-- o.guicursor="a:blinkon0"
o.iskeyword:append("-")

-- Folding
o.foldlevel = 99
o.fillchars = { fold = " " }

-- Tabs and spaces
o.smartindent = false
o.breakindent = true -- wrapped line will continue visually indented
o.expandtab = true
o.showtabline = 0 -- 2 to show tabline
o.shiftwidth = 2 -- number of spaces for each indention
o.tabstop = 2    -- insert N spaces for tab
-- o.tabline = 0
-- let g:airline#extensions#tabline#enabled = 0

-- Search
o.hlsearch = true
o.ignorecase = true

-- Element sizes
o.cmdheight = 1
o.pumheight = 10 -- height of pop up menu

-- Window
o.splitbelow = true -- force split below actual window
o.splitright = true -- force split right of actual window
o.number = true     -- show line numbers
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = "yes" -- alway draw sign column

-- Disable change to tabstop and shiftwidth back to 4
vim.g.markdown_recommended_style = 0

-- Lines
o.cursorline = true -- highlight cursor line
o.wrap = true
o.whichwrap:append("<,>,[,],h,l")
o.linebreak = true
o.scrolloff = 16
o.sidescrolloff = 8

-- Spelling
o.spell = true
o.spelllang = "cs,en_us" -- csa is custom generated cs ascii only TODO add cs

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

o.wildmode = "list:longest,full"
