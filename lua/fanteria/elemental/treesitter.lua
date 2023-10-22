local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
  print("Treesitter cannot be loaded.")
  return
end

treesitter.setup({
  ensure_installed = "all",
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = "",
  },
  incremental_celection = {
    enable = false,
    disable = { "" },
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
    disable = { "" },
  },
})
