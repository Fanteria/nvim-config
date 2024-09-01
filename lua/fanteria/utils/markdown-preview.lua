local M = {}

--- Setup function.
function M.setup()
  local css_path = "css"
  local markdown_preview_css = "markdown-preview.css"

  -- vim.g.mkdp_theme = "light"

  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_page_title = "${name}"
  vim.g.mkdp_combine_preview = 1
  vim.g.mkdp_combine_preview_auto_refresh = 1
  vim.g.mkdp_preview_options = {
    disable_filename = 1,
  }

  local path = require("plenary.path"):new(vim.fn["stdpath"]("config"))
  path = path:joinpath(css_path):joinpath(markdown_preview_css)
  if(path:exists()) then
    vim.g.mkdp_markdown_css = path.filename
  else
    vim.notify("Warning: " .. path.filename .. " does not exists.", "warning")
  end
end

return M
