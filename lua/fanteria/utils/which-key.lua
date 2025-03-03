local M = {}

--- Find names of all modules in some directory.
---@param base_dir string Base directory.
---@return string[] List of found modules.
local function find_modules(base_dir)
  local modules = {}
  local scandir = require("plenary.scandir")
  scandir.scan_dir(base_dir, {
    hidden = true,
    depth = 10, -- Adjust depth as needed
    on_insert = function(file)
      if file:match("%.lua$") then
        -- Convert file path to module name
        local module_path = file:gsub(base_dir .. "/", ""):gsub("%.lua$", ""):gsub("/", ".")
        table.insert(modules, module_path)
      end
    end,
  })
  return modules
end

--- Load keymaps.
---@return table Keymaps.
local function get_keys()
  local merged = {}

  local function add_keys(mappings)
    for _, mapping in ipairs(mappings) do
      local leader = "<leader>"
      if string.sub(mapping[1], 1, #leader) == leader then
        table.insert(merged, mapping)
      else
        local mode = mapping.mode or "n"
        vim.keymap.set(mode, mapping[1], mapping[2], { noremap = true, silent = true })
      end
    end
  end

  -- List all modules and look for `keys` table with keymaps.
  local base_dir = vim.fn.stdpath("config") .. "/lua" -- Adjust as needed
  local modules = find_modules(base_dir)
  for _, module in ipairs(modules) do
    if module ~= "fanteria.plugins" and module ~= "fanteria.functions" then
      local status_ok, required = pcall(require, module)

      if not status_ok then
        vim.notify("Cannot load module" .. module, vim.log.levels.ERROR)
      elseif type(required) == "table" and required.keys ~= nil then
        add_keys(required.keys)
      end
    end
  end

  return merged
end

--- Which-key options.
---@return table Options table
function M.opts()
  return {
    delay = 1200,
    win = {
      padding = { 1, 1 },
    },
    spec = get_keys(),
  }
end

return M
