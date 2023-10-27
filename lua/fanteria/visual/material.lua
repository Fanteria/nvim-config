local M = {}

M.opts = {
  contrast = {
    cursor_line = true,
  },
  plugins = {
    "gitsigns",
    "indent-blankline",
    "illuminate", -- TODO how to separate visual from illuminated
    "nvim-cmp",
    "nvim-tree",
    -- "nvim-web-devicons",
    "telescope",
    "which-key",
    -- "hop",
  },
  lualine_style = "stealth",
  styles = {
    comments = { italic = true },
  },
  high_visibility = {
    lighter = true,
    darker = true,
  },
  async_loading = true,
  custom_colors = function(colors)
    if vim.g.material_style == "darker" then
      colors.editor.bg                       = "#18151a"
      colors.editor.bg_alt                   = "#18151a"
      colors.backgrounds.sidebars            = colors.editor.bg
      colors.backgrounds.floating_windows    = "#141821"
      colors.backgrounds.non_current_windows = colors.editor.bg
    end
    colors.syntax.type = colors.main.yellow
    colors.syntax.operator = colors.main.red

    colors.git.added = colors.main.green
  end,
}

M.custom_highlights = function(c)
  return {
    ["@variable.builtin"]      = { fg = c.main.orange },
    ["@property"]              = { fg = c.main.paleblue },
    ["@parameter"]             = { fg = c.editor.fg },

    ["@type.qualifier"]        = { fg = c.main.orange }, -- public and const keywords

    ["@keyword"]               = { fg = c.main.purple },
    ["@namespace"]             = { fg = c.main.paleblue },
    ["@string.escape"]         = { fg = c.main.orange },

    ["@punctuation.delimiter"] = { fg = c.editor.fg },
    ["@punctuation.bracket"]   = { fg = c.editor.fg },

    ["@constant"]              = { fg = c.main.yellow },
  }
end

M.setup = function (_, opts)
  local material_ok, material = pcall(require, "material")
  if not material_ok then
    vim.cmd("colorscheme default")
    vim.notify("Material colorscheme cannot be loaded.")
    return
  end

  vim.g.material_style = "darker"
  opts.custom_highlights = M.custom_highlights(require("material.colors"))
  material.setup(opts)

  vim.cmd("colorscheme material")
end

return M
