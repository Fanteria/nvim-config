local M = {}

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

return M
