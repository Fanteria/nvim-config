local nvim_web_dev_icons_ok, nvim_web_dev_icons = pcall (require, "nvim-web-devicons")
if not nvim_web_dev_icons_ok then
  print("Nvim web devicons cannot be loaded.")
  return
end

-- Setup of icons in nvim-tree
nvim_web_dev_icons.setup()
