local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then
  print("Gitsigns cannot be loaded")
  return
end

gitsigns.setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "G" },
    changedelete = { text = "▎" },
  },
})
