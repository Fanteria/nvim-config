local M = {}

local function get_keys()
  local merged = {}

  local add_keys = function(mappings)
    for _, mapping in ipairs(mappings) do
      local leader = "<leader>"
      if string.sub(mapping[1],1,#leader) == leader then
        table.insert(merged, mapping)
      else
        local mode = mapping.mode or "n"
        vim.keymap.set(mode, mapping[1], mapping[2], { noremap = true, silent = true })
      end
    end
  end

  add_keys(require("fanteria.keymaps").keys)

  add_keys(require("fanteria.elemental.lspconfig").keys)
  add_keys(require("fanteria.session").keys)
  add_keys(require("fanteria.utils.dap").keys)
  add_keys(require("fanteria.utils.dapui").keys)
  add_keys(require("fanteria.utils.neogen").keys)
  add_keys(require("fanteria.utils.nvim-coverage").keys)
  add_keys(require("fanteria.utils.nvim-tree").keys)
  add_keys(require("fanteria.utils.trouble").keys)
  add_keys(require("fanteria.visual.gitsigns").keys)
  add_keys(require("fanteria.utils.telescope").keys)
  add_keys(require("fanteria.utils.gen").keys)

  return merged
end

M.opts = {
  delay = 1200,
  win = {
    padding = { 1, 1 },
  },
  spec = get_keys(),
}

return M
