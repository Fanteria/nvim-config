local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
  print("Bufferline cannot be loaded.")
  return
end

bufferline.setup({
  options = {
    -- themable = true,
    -- style_preset = bufferline.style_preset.minimal,
    offsets = {
      { filetype = "NvimTree", text = "File explorer" },
      { filetype = "undotree", text = "Undo tree" },
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    tab_size = 5,
    sort_by = function(a, b)
      return a.name < b.name
    end
  }
})
