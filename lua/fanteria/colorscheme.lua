local material_ok, material = pcall(require, "material")
if not material_ok then
  vim.cmd("colorscheme default")
  print("Material colorscheme cannot be loaded.")
  return
end

vim.g.material_style = "darker"

material.setup({
  contrast = {
    cursor_line = true,
  },
  styles = {
    comments = { italic = true },
  },
  high_visibility = {
    lighter = true,
    darker = true,
  },
  async_loading = true,
  -- lualine_style
  -- custom_highlights
  -- custom_colors
})

vim.cmd("colorscheme material")
