local M = {}
local custom_config = "custom"

-- Can be:
-- `nil` - nothing is selected
-- `"custom"` - se custom configuration on start of the program
M.act_conf = nil

M.select_debug_config = function(opts)
  opts = opts or {}
  local cwd = vim.loop.cwd()
  local debug_config_file = cwd .. "/.debug-config.lua"
  local fs_stat = vim.loop.fs_stat(debug_config_file)
  if fs_stat == nil or fs_stat.type ~= "file" then
    vim.notify("Config script for debug does not exists.")
    M.act_conf = nil
    return
  end

  dofile(debug_config_file)
  if GetDapConfigs == nil then
    vim.notify(
      "File " .. debug_config_file .. " does not contain global function GetDapConfigs",
      vim.log.lovels.ERROR)
    return
  end
  local dap_configs = GetDapConfigs(cwd)

  local actions = require("telescope.actions")
  local buffers = {}
  for key, _ in pairs(dap_configs) do
    table.insert(buffers, key)
  end
  table.insert(buffers, custom_config)
  local routine = coroutine.create(
    function()
      require("telescope.pickers").new(opts, {
        prompt_title = "Buffers in tabs",
        finder = require("telescope.finders").new_table({ results = buffers }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selected = require("telescope.actions.state").get_selected_entry()[1]
            if selected == custom_config then
              M.act_conf = nil
            else
              M.act_conf = dap_configs[selected]
            end
          end)
          return true
        end,
      }):find()
    end)
  coroutine.resume(routine)
  while coroutine.status(routine) ~= 'dead' do
    vim.wait(100, function() return coroutine.status(routine) == 'dead' end, 1)
  end
  vim.notify("TEST")
end

local function stringToWordArray(str)
  local wordArray = {}
  for word in str:gmatch("%S+") do
    table.insert(wordArray, word)
  end
  return wordArray
end

local function get_custom_program(cwd)
  local path
  vim.ui.input(
    { prompt = "Path to executable: ", default = cwd },
    function(input)
      path = input
    end
  )
  vim.cmd [[redraw]]
  return path
end

local function get_custom_args()
  local arguments
  vim.ui.input(
    { prompt = "Arguments: " },
    function(input)
      arguments = input
    end
  )
  vim.cmd [[redraw]]
  return arguments
end

M.get_mappings = function()
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
        if M.act_conf == nil or M.act_conf == custom_config then
          return get_custom_program(vim.loop.cwd())
        else
          vim.notify(M.act_conf)
          return M.act_conf.program or ""
        end
      end,
      args = function()
        if M.act_conf == nil or M.act_conf == custom_config then
          return stringToWordArray(get_custom_args())
        else
          vim.notify(M.act_conf)
          return M.act_conf.args or {}
        end
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    }
  },
}

M.configurations.c = M.configurations.cpp
M.configurations.rust = M.configurations.cpp

M.setup = function(_, _)
  local dap = require("dap")
  for name, adapter in pairs(M.adapters) do
    dap.adapters[name] = adapter
  end
  for name, configuration in pairs(M.configurations) do
    dap.configurations[name] = configuration
  end
end

local fn = require("utils").fn
M.keys = {
  {
    "<leader>B",
    fn("dap", function(d) d.toggle_breakpoint() end),
    desc = "Toggle breakpoint"
  },

  { "<leader>d", group = "Debugger" },
  {
    "<leader>dr",
    fn("dap", function(dap) -- TODO
      if M.act_conf == nil then
        M.select_debug_config({ new = true })
      end
      dap.continue()
    end),
    desc = "Run debugger",
  },
  {
    "<leader>db",
    fn("dap", function(r) r.dap.toggle_breakpoint() end),
    desc = "Toggle breakpoint",
  },
  {
    "<leader>ds", -- TODO
    M.select_debug_config,
    desc = "Select debugger config",
  },
  {
    "<leader>dR",
    fn("dap.repl", function(d) d.toggle({ height = 15 }) end),
    desc = "Toggle REPL",
  },
  {
    "<leader>de",
    fn("dap.ui.widgets", function(w) w.sidebar(w.expression).open() end),
    desc = "Toggle expression",
  },
}

return M
