local M = {}

M.get_mappings = function ()
  local dap = require("dap")
  local dap_mappings = {
    ["r"] = dap.restart,
    ["c"] = dap.continue,
    ["n"] = dap.step_over,
    ["s"] = dap.step_into,
    ["fin"] = dap.step_out,
  }
  return dap_mappings
end

M.adapters = {
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    }
  }
}

M.configurations = {
  cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local path
        vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/discord-party-bot" }, function(input)
          path = input
        end)
        vim.cmd [[redraw]]
        return path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    }
  },
}

M.configurations.c = M.configurations.cpp
M.configurations.rust = M.configurations.cpp

M.setup = function (_, _)
  local dap = require("dap")
  for name, adapter in pairs(M.adapters) do
    dap.adapters[name] = adapter
  end
  for name, configuration in pairs(M.configurations) do
    dap.configurations[name] = configuration
  end
end

return M
