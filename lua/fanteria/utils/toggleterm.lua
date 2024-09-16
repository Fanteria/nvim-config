local M = {}

local lua = nil

M.opts = {

}

local fn = require("utils").fn
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
  },
  { "<leader>x", group = "Terminal" },
  {
    "<leader>xt",
    fn("toggleterm.terminal", function(t)
      if lua == nil then
        lua = t.Terminal:new()
        lua:toggle()
      else
        lua:toggle()
      end
    end),
    desc = "Terminal",
  },
  {
    "<leader>xl",
    fn("toggleterm.terminal", function(t)
      if lua == nil then
        lua = t.Terminal:new({ cmd = "lua" })
        lua:toggle()
      else
        lua:toggle()
      end
    end),
    desc = "Lua",
  },
  {
    "<leader>xp",
    fn("toggleterm.terminal", function(t)
      if lua == nil then
        lua = t.Terminal:new({ cmd = "python" })
        lua:toggle()
      else
        lua:toggle()
      end
    end),
    desc = "Python",
  },
  {
    "<leader>xc",
    fn("toggleterm.terminal", function(t)
      if lua == nil then
        lua = t.Terminal:new({ cmd = "clang-repl" })
        lua:toggle()
      else
        lua:toggle()
      end
    end),
    desc = "C/C++",
  },
}

return M
