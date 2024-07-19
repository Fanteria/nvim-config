local M = {}

local fn = require("utils").fn

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local function maph(mapping, function_to_run)
  if type(mapping) == "string" then
    table.insert(M.keys, {mapping, function_to_run, mode = { "n" }, hidden = true})
  else
    table.insert(M.keys, mapping)
  end
end

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

  {
    "<leader>O",
    "<cmd>execute '!xdg-open' shellescape(expand('<cfile>', 1))<CR>",
    desc = "Open path"
  },


  hidden_mappings
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
maph("<leader>w", "<cmd>w!<CR>")
maph("<leader>q", "<cmd>q!<CR>")
maph("<leader>Q", "<cmd>wqa<CR>")

-- hide highlight
maph("<leader>H", "<cmd>nohlsearch<CR>")

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
map("n", "}", function() find_paragraph('W') end)
map("n", "{", function() find_paragraph('Wb') end)

-- Windows --
-- Navigation in windows
maph("<leader>h", "<C-w>h")
maph("<leader>j", "<C-w>j")
maph("<leader>k", "<C-w>k")
maph("<leader>l", "<C-w>l")

-- Change size of window
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tabs --
map("n", "<C-t>", fn({"fanteria.functions", "telescope.themes"}, function(f)
  f["fanteria.functions"].telescope_buffers_in_tabs(f["telescope.themes"].get_dropdown({ previewer = false }))
end), opts)

maph("<leader>tn", ":tabnew %<CR>")
maph("<leader>tc", vim.cmd.tabclose)
maph("<leader>tC", fn("fanteria.functions", function (f) f.close_not_open_bufs() end))
maph("<leader>tl", ":tabm +1<CR>")
maph("<leader>th", ":tabm -1<CR>")
map("n", "<S-l>", vim.cmd.tabnext, opts)
map("n", "<S-h>", vim.cmd.tabprev, opts)

-- Tab numbers mappings for czech keyboard
maph("<leader>t+", "1gt")
maph("<leader>tě", "2gt")
maph("<leader>tš", "3gt")
maph("<leader>tč", "4gt")
maph("<leader>tř", "5gt")
maph("<leader>tž", "6gt")
maph("<leader>tý", "7gt")
maph("<leader>tá", "8gt")
maph("<leader>tí", "9gt")
maph("<leader>té", "0gt")

-- Tab mappings by numbers
for i = 1, 9 do
  maph("<leader>t:" .. i, i .. "gt")
end
maph("<leader>t0", ":tablast<CR>")

-- Bufferline
map("n", "<C-l>", "<cmd>bn<CR>", opts)
map("n", "<C-h>", "<cmd>bp<CR>", opts)
maph("<leader>c", "<cmd>Bdelete<CR>")

-- Switch source and header
map("n", "gh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
map("n", "gSh", "<cmd>split | ClangdSwitchSourceHeader<cr>", opts)
map("n", "gsh", "<cmd>vsplit | ClangdSwitchSourceHeader<cr>", opts)

-- Hop
maph({
  "<leader>s",
  fn("hop", function(h) h.hint_char1({ multi_windows = true }) end),
  mode = { "n", "v", "x" }
})
map({ "n", "v", "x" }, "s", fn({ "hop", "hop.hint" }, function(r)
  r["hop"].hint_char1({ direction = r["hop.hint"].AFTER_CRUSOR, current_line_only = true })
end), opts)
map({ "n", "v", "x" }, "S", fn({ "hop", "hop.hint" }, function(r)
  r["hop"].hint_char1({ direction = r["hop.hint"].BEFORE_CURSOR, current_line_only = true })
end), opts)

map("n", "gC", fn("treesitter-context", function(t) t.go_to_context() end), opts)

-----------------
-- Visual mode --
-----------------
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "p", '"_dP', opts)

maph({
  "<leader>f",
  fn("conform", function(c)
    c.format({ async = true, lsp_fallback = true })
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  end),
  mode = { "n", "v", "x" },
})

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
