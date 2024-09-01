local M = {}

--- Neogen options.
M.opts = {
  enabled = true,
  snippet_engine = "luasnip",
  placeholders_text = {
    ["description"] = "TODO: description",
    ["tparam"] = "TODO: tparam",
    ["parameter"] = "TODO: parameter",
    ["return"] = "TODO: return",
    ["class"] = "TODO: class",
    ["throw"] = "TODO: throw",
    ["varargs"] = "TODO: varargs",
    ["type"] = "TODO: type",
    ["attribute"] = "TODO: attribute",
    ["args"] = "TODO: args",
    ["kwargs"] = "TODO: kwargs",
  },
}

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>D", group = "Documentation" },
  {
    "<leader>DC",
    fn("neogen", function(n) n.generate({ type = 'class' }) end),
    desc = "Class",
  },
  {
    "<leader>DF",
    fn("neogen", function(n) n.generate({ type = 'func' }) end),
    desc = "Function",
  },
  {
    "<leader>DT",
    fn("neogen", function(n) n.generate({ type = 'type' }) end),
    desc = "Type",
  },
  {
    "<leader>Df",
    fn("neogen", function(n) n.generate({ type = 'file' }) end),
    desc = "File",
  },
}

return M
