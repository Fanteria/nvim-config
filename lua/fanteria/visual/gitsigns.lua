local M = {}

M.opts = {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
}

M.setup = function(plug, opts)
  print(vim.inspect(plug))
  local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
  if not gitsigns_ok then
    vim.notify(plug.name .. " cannot be loaded")
    return
  end
  gitsigns.setup(opts)
end

return M
