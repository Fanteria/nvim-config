local M = {}

--- Trouble options.
M.opts = {}

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>T", group = "Trouble" },
  {
    "<leader>TD",
    fn("trouble", function(t) t.toggle({ mode = "diagnostics", focus = true }) end),
    desc = "Diagnostics",
  },
  {
    "<leader>TI",
    fn("trouble", function(t) t.toggle({ mode = "lsp_incoming_calls", focus = true }) end),
    desc = "Incoming",
  },
  {
    "<leader>TO",
    fn("trouble", function(t) t.toggle({ mode = "lsp_outgoing_calls", focus = true }) end),
    desc = "Outcoming",
  },
  {
    "<leader>TR",
    fn("trouble", function(t) t.toggle({ mode = "lsp_references", focus = true }) end),
    desc = "References",
  },
}

return M
