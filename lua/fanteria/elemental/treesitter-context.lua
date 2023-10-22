local treesitter_context_ok, treesitter_context = pcall(require, "treesitter-context")
if not treesitter_context_ok then
  return
end

treesitter_context.setup()

-- TODO
-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context()
-- end, { silent = true })
