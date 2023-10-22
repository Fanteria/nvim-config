local neogen_ok, neogen = pcall(require, "neogen")
if not neogen_ok then
  return
end

neogen.setup({
  enabled = true,
  snippet_engine = "luasnip",
})
