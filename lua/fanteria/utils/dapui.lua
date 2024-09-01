local M = {}

--- Setup function.
function M.setup()
  local dapui = require("dapui")
  dapui.setup()

  local colors = require("material.colors")
  vim.api.nvim_set_hl(0, "DapStoppedHL", {
    bg = require("material.functions").darken(colors.main.green, 0.15, colors.editor.bg)
  })
  vim.api.nvim_set_hl(0, "DapBreakpointHL", { fg = colors.main.red })

  vim.fn.sign_define('DapBreakpoint', {
    text = '',
    texthl = 'DapBreakpointHL',
    linehl = '',
    numhl = ''
  })
  vim.fn.sign_define('DapBreakpointCondition', {
    text = 'C',
    texthl = '',
    linehl = '',
    numhl = ''
  })
  vim.fn.sign_define('DapLogPoint', {
    text = 'L',
    texthl = '',
    linehl = '',
    numhl = ''
  })
  vim.fn.sign_define('DapStopped', {
    text = '',
    texthl = 'DapStoppedHL',
    linehl = 'DapStoppedHL',
    numhl = ''
  })
  vim.fn.sign_define('DapBreakpointRejected', {
    text = '󰅙',
    texthl = '',
    linehl = '',
    numhl = ''
  })
end

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  {
    "<leader>dt",
    fn("dapui", function(d) d.toggle() end),
    desc = "Toggle debugger",
  },
}

return M
