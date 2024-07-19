local M = {}

local function load_required(required)
  if type(required) == "string" then
      local status_ok, package = pcall(require, required)
      if status_ok then
        return package
      else
        vim.notify("Package '" .. required .. "' cannot be loaded.")
        return nil
      end
  else
    local loaded_required = {}
    for _, name in ipairs(required) do
      local status_ok, package = pcall(require, name)
      if status_ok then
        loaded_required[name] = package
      else
        vim.notify("Package '" .. name .. "' cannot be loaded.")
        return nil
      end
    end
    return loaded_required
  end
end

-- TODO describe
--- Function caller that require package if exists, else notify user.
---@param package_names string|table[string] Name of package to load.
---@param function_to_run function Function to run.
M.fn = function(package_names, function_to_run)
  return function()
    if package_names == nil then
      function_to_run()
    else
      local required = load_required(package_names)
      if required == nil then
        return
      else
        function_to_run(required)
      end
    end
  end
end

return M
