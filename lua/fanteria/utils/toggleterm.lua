local M = {}

M.opts = {

}

M.keys = {
  {
    "<C-l>",
    "<cmd>ToggleTerm<CR>",
    mode = { "n", "t" }
  },
  {
    "<Esc>",
    "<C-\\><C-n>",
    mode = { "t" }
  }
}

return M
