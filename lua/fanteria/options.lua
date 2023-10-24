local o = vim.opt;

-- Basic
o.backup = false
o.writebackup = false
o.clipboard = "unnamedplus" -- allow to use system clipboard
o.fileencoding = "utf-8"
o.swapfile = false
o.mouse = "a"

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
o.foldlevel = 20
-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldtext = "substitute(getline(v:foldstart),'\\t',repeat(' ',&tabstop),'g').' ... '.trim(getline(v:foldend))" -- formatted folding
o.fillchars = "fold: "
o.foldnestmax = 3
o.foldminlines = 1
o.foldcolumn = '0'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Tabs and spaces
o.smartindent = true
o.breakindent = true -- wrapped line will continue visually indented
o.expandtab = true
o.showtabline = 2
o.shiftwidth = 2 -- number of spaces for each indention
o.tabstop = 2    -- insert N spaces for tab

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
