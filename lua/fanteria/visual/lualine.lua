local M = {}

M.opts = {
  options = {
    disabled_filetypes = { "alpha", "NvimTree" },
    theme = "auto",
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_b = { { "branch", icon = "" }, "diagnostics" },
    lualine_x = {
      { "diff", symbols = { added = " ", modified = " ", removed = " " } },
      {
        "tabs",
        padding = 1,
        tabs_color = {
          active = 'lualine_a_normal',
          inactive = 'lualine_c_inactive',
        },
      },
      "filetype",
    },
    lualine_y = {
      { "location", padding = 0 },
    },
    lualine_z = {
      { "progress", padding = 1 }
    },
  },
}

return M
