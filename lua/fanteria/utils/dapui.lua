local M = {}

M.prev_mappings = nil

M.toggle_dap_ui = function()
  local dap_mappings = require("fanteria.utils.dap").get_mappings()
  local dapui = require("dapui")
  dapui.open()
  if not M.prev_mappings then
    local maps = vim.api.nvim_get_keymap("n")
    M.prev_mappings = {}
    for key, _ in pairs(dap_mappings) do
      for _, value in ipairs(maps) do
        if value.lhs == key then
          M.prev_mappings[key] = value
        end
      end
    end
    for key, value in pairs(dap_mappings) do
      vim.keymap.set("n", key, value, { noremap = true, silent = true })
    end
  else
    for key, _ in pairs(dap_mappings) do
      local act = M.prev_mappings[key]
      if act then
        if act.rhs then
          vim.keymap.set("n", key, M.prev_mappings[key].rhs)
        else
          vim.keymap.set("n", key, M.prev_mappings[key].callback)
        end
      else
        vim.keymap.del("n", key)
      end
    end

    dapui.close()
    M.prev_mappings = nil
  end
end

M.setup = function (_, _)
  local dapui = require("dapui")
  local dap = require("dap")
  dapui.setup()

  vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
  vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "yellow", { fg = "#ffff00" })
  vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

  vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint', linehl='', numhl=''})
  vim.fn.sign_define('DapBreakpointCondition', {text='C', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapLogPoint', {text='L', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='', texthl='orange', linehl='orange', numhl=''})
  vim.fn.sign_define('DapBreakpointRejected', {text='󰅙', texthl='', linehl='', numhl=''})
end

return M
