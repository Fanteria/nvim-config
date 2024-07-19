local M = {}

local function get_keys()
  local merged = {}

  local add_keys = function(mappings)
    for _, mapping in ipairs(mappings) do
      table.insert(merged, mapping)
    end
  end

  add_keys(require("fanteria.keymaps").keys)

  add_keys(require("fanteria.session").keys)
  add_keys(require("fanteria.utils.neogen").keys)
  add_keys(require("fanteria.utils.nvim-coverage").keys)
  add_keys(require("fanteria.utils.trouble").keys)
  add_keys(require("fanteria.visual.gitsigns").keys)
  add_keys(require("fanteria.elemental.lspconfig").keys)
  add_keys(require("fanteria.utils.dapui").keys)
  add_keys(require("fanteria.utils.dap").keys)

  return merged
end

M.opts = {
  delay = 120,
  win = {
    padding = { 1, 1 },
  },
  spec = get_keys(),
}

return M
