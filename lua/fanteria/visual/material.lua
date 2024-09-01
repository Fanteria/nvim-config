local M = {}

--- Material options.
M.opts = {
  contrast = {
    cursor_line = true,
  },
  plugins = {
    "gitsigns",
    "indent-blankline",
    -- "illuminate",
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
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underdouble = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })
    colors.syntax.type = colors.main.yellow
    colors.syntax.operator = colors.main.red

    colors.git.added = colors.main.green
  end,
}

--- Create custom highlights.
---@param c table Colors.
---@return table Custom highlights.
function M.custom_highlights(c)
  local h = {}

  h.Structure = { fg = c.main.purple }
  h.Statement = { fg = c.main.purple }
  h.StorageClass = { fg = c.main.purple }

  h["@property"]              = { fg = c.main.paleblue }
  h["@namespace"]             = { fg = c.main.paleblue }
  h["@keyword"]               = { fg = c.main.purple }
  h["Exception"]              = { fg = c.main.red }

  h['@lsp.mod.virtual.cpp']   = { italic = true }

  -- luasnip
  h.DiagnosticHint = { fg = c.main.cyan }

  -- doxygen
  h.doxygenBrief = { fg = c.main.cyan }
  h.doxygenSpecial = { link = "Comment" }
  h.doxygenParamName = { link = "Identifier" }
  h.doxygenSpecialMultilineDesc = { link = "Comment" }

  -- C++
  h.cppStatement = { fg = c.main.purple }
  h.cppModifier = { fg = c.main.orange }
  h["@lsp.type.operator.cpp"] = {}

  -- Rust
  h.rustSelf = { fg = c.main.orange }
  h["@lsp.type.selfKeyword.rust"] = { link = "rustSelf" }
  h["@lsp.type.struct.rust"] = { link = "@type"}

  return h
end

--- Setup function.
---@param _ table Plugin data.
---@param opts ?table Options.
function M.setup(_, opts)
  local material_ok, material = pcall(require, "material")
  if not material_ok then
    vim.cmd("colorscheme default")
    vim.notify("Material colorscheme cannot be loaded.")
    return
  end

  vim.g.material_style = "darker"
  local colors = require("material.colors")
  opts.custom_highlights = M.custom_highlights(colors)
  material.setup(opts)

  vim.cmd("colorscheme material")
end

return M
