local M = {}

--- Add to window auto command that will close it on leave.
---@param win integer Window id.
local function close_floating_win_on_leave(win)
  vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
    once = true,
  })
end

--- Loads configurations from .vscode/launch.json
function M.load_configurations()
  local dap = require("dap")
  dap.configurations = {}
  require("dap.ext.vscode").load_launchjs(nil, { codelldb = { 'c', 'cpp', 'rust' } })
end

--- Start debugging from configuration.
--- @param opts ?table Telescope options
function M.start(opts)
  opts = opts or {}
  local dap = require("dap")
  local configurations = dap.configurations[vim.bo.filetype]

  if configurations == nil or #configurations == 0 then
    M.load_configurations()
    configurations = dap.configurations[vim.bo.filetype]
  end

  if #configurations == 0 then
    vim.notify("There is no configuration", vim.log.levels.ERROR)
    return
  elseif #configurations == 1 then
    vim.notify("Run configuration:\n" .. vim.inspect(configurations[1]), vim.log.levels.INFO)
    require("dap").run(configurations[1])
    return
  end

  local options = {}
  local config_table = {}
  for _, configuration in pairs(configurations) do
    config_table[configuration.name] = configuration
    table.insert(options, configuration.name)
  end

  require("fanteria.utils.telescope").open_selection(
    "DAP configurations",
    options,
    function(selected_option)
      local selected = config_table[selected_option]
      vim.notify("Run configuration:\n" .. vim.inspect(selected), vim.log.levels.INFO)
      require("dap").run(selected)
    end)
end

--- Setup function.
function M.setup()
  -- Debug adapters wiki.
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-gdb
  local dap = require("dap")
  -- Codelldb manual.
  -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    }
  }
end

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>d",  group = "Debugger" },
  {
    "<leader>db",
    fn("dap", function(d) d.toggle_breakpoint() end),
    desc = "Toggle breakpoint",
  },

  {
    "<F5>",
    fn("dap", function(d) d.continue() end),
    desc = "Continue"
  },
  {
    "<F6>",
    fn("dap", function(d) d.run_to_cursor() end),
    desc = "Run to cursor"
  },
  {
    "<F10>",
    fn("dap", function(d) d.step_over() end),
    desc = "Step over"
  },
  {
    "<F11>",
    fn("dap", function(d) d.step_into() end),
    desc = "Step into"
  },
  {
    "<F12>",
    fn("dap", function(d) d.step_out() end),
    desc = "Step out"
  },
  {
    "<leader>dq",
    fn("dap", function(d) d.disconnect() end),
    desc = "Quit debugger",
  },
  {
    "<Leader>dR",
    fn("dap", function(d) d.repl.toggle() end),
    desc = "Open repl"
  },
  {
    "<Leader>dr",
    fn("dap", function(d) d.run_last() end),
    desc = "Rerun last"
  },
  {
    "<Leader>dg",
    fn("dap", function(d) d.goto_(tonumber(vim.fn.input("Line:"))) end),
    desc = "Go to line"
  },
  {
    "<Leader>dh",
    fn("dap.ui.widgets", function(d)
      close_floating_win_on_leave(d.hover(nil, { border = "rounded" }).win)
    end),
    desc = "Hover preview"
  },
  { -- load configuration again is needed only if is updated after first use of debugger
    "<leader>dc",
    M.load_configurations,
    desc = "load configurations",
  },
  {
    "<leader>dS",
    M.start,
    desc = "start debugger",
  },

  { "<leader>df", group = "Floating widgets" },
  { "<leader>ds", group = "Sidebar widgets" },
  {
    '<Leader>dff',
    fn('dap.ui.widgets', function(w)
      close_floating_win_on_leave(w.centered_float(w.frames).win)
    end),
    desc = "Frames"
  },
  {
    '<Leader>dsf',
    fn('dap.ui.widgets', function(w)
      local sidebar = w.sidebar(w.frames)
      sidebar.open()
    end),
    desc = "Frames"
  },
  {
    '<Leader>dfs',
    fn('dap.ui.widgets', function(w)
      close_floating_win_on_leave(w.centered_float(w.scopes))
    end),
    desc = "Scopes"
  },
  {
    '<Leader>dss',
    fn('dap.ui.widgets', function(w)
      local sidebar = w.sidebar(w.scopes)
      sidebar.open()
    end),
    desc = "Scopes"
  },
  {
    '<Leader>dfS',
    fn('dap.ui.widgets', function(w)
      close_floating_win_on_leave(w.centered_float(w.sessions))
    end),
    desc = "Sessiongs"
  },
  {
    '<Leader>dsS',
    fn('dap.ui.widgets', function(w)
      local sidebar = w.sidebar(w.sessions)
      sidebar.open()
    end),
    desc = "Sessions"
  },
  {
    '<Leader>dfe',
    fn('dap.ui.widgets', function(w)
      close_floating_win_on_leave(w.centered_float(w.expression))
    end),
    desc = "Expression"
  },
  {
    '<Leader>dse',
    fn('dap.ui.widgets', function(w)
      local sidebar = w.sidebar(w.expression)
      sidebar.open()
    end),
    desc = "Expression"
  },
  {
    '<Leader>dft',
    fn('dap.ui.widgets', function(w)
      close_floating_win_on_leave(w.centered_float(w.threads))
    end),
    desc = "Threads"
  },
  {
    '<Leader>dst',
    fn('dap.ui.widgets', function(w)
      local sidebar = w.sidebar(w.threads)
      sidebar.open()
    end),
    desc = "Threads"
  },
}

return M
