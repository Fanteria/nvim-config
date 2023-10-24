local treesitter_context_ok, treesitter_context = pcall(require, "treesitter-context")
if not treesitter_context_ok then
  return
end

treesitter_context.setup({
  enable = true,
  multiline_threshold = 7,
})
