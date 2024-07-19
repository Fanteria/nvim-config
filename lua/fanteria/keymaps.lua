local M = {}

local fn = require("utils").fn

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

M.keys = {
  -- TODO can conflict with tabs maps.
  { "<leader>t", group = "Toggle" },
  {
    "<leader>tw",
    function() vim.opt.wrap = not vim.opt.wrap:get() end,
    desc = "Wrap",
  },
  {
    "<leader>ts",
    function() vim.opt.spell = not vim.opt.spell:get() end,
    desc = "Spell"
  },
  {
    "<leader>tW",
    fn("fanteria.visual.indent-blankline", function(i) i.toggle_whitespaces() end),
    desc = "Whitespaces",
  },

  {
    "<leader>y",
    '<cmd>let @+ = expand("%:p")<CR>',
    desc = "Yank buffer path",
  },

  { "<leader>X", group = "Options" },
  {
    "<leader>Xc",
    fn("telescope", function(t) t.colorscheme() end),
    desc = "Colorscheme",
  },
  {
    "<leader>Xh",
    fn("telescope", function(t) t.help_tags() end),
    desc = "Find Help",
  },
  {
    "<leader>Xm",
    fn("telescope", function(t) t.man_pages() end),
    desc = "Man Pages",
  },
  {
    "<leader>Xr",
    fn("telescope", function(t) t.oldfiles() end),
    desc = "Open Recent File",
  },
  {
    "<leader>XR",
    fn("telescope", function(t) t.registers() end),
    desc = "Registers",
  },
  {
    "<leader>Xk",
    fn("telescope", function(t) t.keymaps() end),
    desc = "Keymaps",
  },
  {
    "<leader>XC",
    fn("telescope", function(t) t.commands() end),
    desc = "Commands",
  },
  {
    "<leader>XL",
    "<cmd>Lazy<CR>",
    desc = "Lazy"
  },

  {
    "<leader>O",
    "<cmd>execute '!xdg-open' shellescape(expand('<cfile>', 1))<CR>",
    desc = "Open path"
  },

  {
    "<leader>u",
    fn("telescope", function(t)
      t.extensions.undo.undo()
      local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end),
    desc = "Undotree",
  },

  -- Hidden
  {
    hidden = true,
    mode = { "n" },

    -----------------
    -- Normal mode --
    -----------------

    -- Basics --
    { "<leader>w", "<cmd>w!<CR>" },
    { "<leader>q", "<cmd>q!<CR>" },
    { "<leader>Q", "<cmd>wqa<CR>" },

    -- hide highlight
    { "<leader>H", "<cmd>nohlsearch<CR>" },

    -- Windows --
    -- Navigation in windows
    { "<leader>h", "<C-w>h" },
    { "<leader>j", "<C-w>j" },
    { "<leader>k", "<C-w>k" },
    { "<leader>l", "<C-w>l" },

    -- Tabs --
    {
      "<C-t>",
      fn({"telescope.themes", "fanteria.functions"}, function(t)
        t["fanteria.functions"].telescope_buffers_in_tabs(t["telescope_theme"].get_dropdown({ previewer = false }))
      end)
    },

    -- Extensions --
    -- File explorer
    {
      "<leader>e",
      fn("nvim-tree.api", function(n) n.tree.toggle() end),
    },

  },
}

-- Map <leader> key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal mode --
-----------------
-- disable clipboard for `x` in normal mode
map("n", "x", '"_x', opts)
map("n", "X", '"_X', opts)

-- swap Mark bindings
map("n", "`", "m", opts)
map("n", "m", "`", opts)

-- Basics --
-- map("n", "<leader>w", "<cmd>w!<CR>", opts)
-- map("n", "<leader>q", "<cmd>q!<CR>", opts)
-- map("n", "<leader>Q", "<cmd>wqa<CR>", opts)
-- hide highlight
-- map("n", "<leader>H", "<cmd>nohlsearch<CR>", opts)

-- fix last misspell
map("n", "<C-f>", "mx[s1z=`x", opts)
map("i", "<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)

-- paragraph is separated not only by empty lines, but also by lines with white spaces
-- also folded paragraphs are ignored
local function find_paragraph(flags)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local new_line = vim.fn.search('^\\s*$', flags)
  if vim.fn.abs(current_line - new_line) == 1 or vim.fn.foldclosedend(new_line) ~= -1 then
    find_paragraph(flags)
  end
end
map("n", "}", function()
  find_paragraph('W')
end)
map("n", "{", function()
  find_paragraph('Wb')
end)

-- Windows --
-- Navigation in windows
-- map("n", "<leader>h", "<C-w>h", opts)
-- map("n", "<leader>j", "<C-w>j", opts)
-- map("n", "<leader>k", "<C-w>k", opts)
-- map("n", "<leader>l", "<C-w>l", opts)

-- Change size of window
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tabs --
-- local telescope_theme_ok, telescope_theme = pcall(require, "telescope.themes")
-- if telescope_theme_ok then
--   map("n", "<C-t>", function()
--     require("fanteria.functions").telescope_buffers_in_tabs(telescope_theme.get_dropdown({ previewer = false }))
--   end, opts)
-- end

-- telescope.buffers(telescope_theme.get_dropdown({ previewer = false }))
map("n", "<leader>tn", ":tabnew %<CR>", opts)
map("n", "<leader>tc", vim.cmd.tabclose, opts)
map("n", "<leader>tC", require("fanteria.functions").close_not_open_bufs, opts)
map("n", "<leader>tl", ":tabm +1<CR>", opts)
map("n", "<leader>th", ":tabm -1<CR>", opts)
map("n", "<S-l>", vim.cmd.tabnext, opts)
map("n", "<S-h>", vim.cmd.tabprev, opts)

-- Tab numbers mappings for czech keyboard
map("n", "<leader>t+", "1gt", opts)
map("n", "<leader>tě", "2gt", opts)
map("n", "<leader>tš", "3gt", opts)
map("n", "<leader>tč", "4gt", opts)
map("n", "<leader>tř", "5gt", opts)
map("n", "<leader>tž", "6gt", opts)
map("n", "<leader>tý", "7gt", opts)
map("n", "<leader>tá", "8gt", opts)
map("n", "<leader>tí", "9gt", opts)
map("n", "<leader>té", "0gt", opts)

-- Tab mappings by numbers
for i = 1, 9 do
  map("n", "<leader>t:" .. i, i .. "gt", opts)
end
map("n", "<leader>t0", ":tablast<CR>", opts)

-- Bufferline
-- local bufferline_ok, _ = pcall(require, "bufferline")
-- if bufferline_ok then
--   map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
--   map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
-- end
map("n", "<C-l>", "<cmd>bn<CR>", opts)
map("n", "<C-h>", "<cmd>bp<CR>", opts)
map("n", "<leader>c", "<cmd>Bdelete<CR>", opts)

-- Telescope
map("n", "<leader>F", fn("telescope.builtin", function(t) t.live_grep() end))
map("n", "<C-p>", fn("telescope.builtin", function(t) t.find_files() end))
map("n", "<C-b>", fn({"telescope.builtin", "telescope.themes"}, function(r)
  r["telescope.builtin"].buffers(r["telescope.theme"].get_dropdown({ previewer = false }))
end))

-- Switch source and header
map("n", "gh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
map("n", "gSh", "<cmd>split | ClangdSwitchSourceHeader<cr>", opts)
map("n", "gsh", "<cmd>vsplit | ClangdSwitchSourceHeader<cr>", opts)

-- Hop
local hop_ok, hop = pcall(require, "hop")
local hop_hint_ok, hop_hint = pcall(require, "hop.hint")
if hop_ok and hop_hint_ok then
  local d = hop_hint.HintDirection

  map({ "n", "v", "x" }, "<leader>s", function()
    hop.hint_char1({ multi_windows = true })
  end, opts)

  map({ "n", "v", "x" }, "s", function()
    hop.hint_char1({ direction = d.AFTER_CRUSOR, current_line_only = true })
  end, opts)

  map({ "n", "v", "x" }, "S", function()
    hop.hint_char1({ direction = d.BEFORE_CURSOR, current_line_only = true })
  end, opts)
end

local context_ok, context = pcall(require, "treesitter-context")
if context_ok then
  map("n", "gC", context.go_to_context, opts)
end

-----------------
-- Visual mode --
-----------------
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "p", '"_dP', opts)

map("n", "gqq", "gggqG", opts)

local conform_ok, conform = pcall(require, "conform")
if conform_ok then
  map({ "n", "v", "x" }, "<leader>f", function()
    conform.format({ async = true, lsp_fallback = true })
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  end, opts)
end

-----------------
-- Visual block mode --
-----------------
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Sort selected lines
map("x", "<C-s>s", ":sort<CR>", opts)
map("x", "<C-s>u", ":sort u<CR>", opts)

return M
