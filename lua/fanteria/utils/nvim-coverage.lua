local M = {}

--- Nvim-coverage options.
M.opts = {
  summary = {
    height_percentage = 0.75,
  },
  lang = {
    rust = {
      coverage_command = "cargo llvm-cov --lcov --output-path lcov.info"
    },
  },
  lcov_file = "lcov.info"
}

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>C", group = "Coverage" },
  {
    "<leader>CA",
    fn("coverage", function(c) c.summary() end),
    desc = "All",
  },
  {
    "<leader>CC",
    fn("coverage", function(c) c.clear() end),
    desc = "Clear",
  },
  {
    "<leader>CH",
    fn("coverage", function(c) c.hide() end),
    desc = "Hide",
  },
  {
    "<leader>CL",
    "<cmd>CoverageLoadLcov lcov.info<cr>",
    desc = "Load",
  },
  {
    "<leader>CS",
    fn("coverage", function(c) c.show() end),
    desc = "Show",
  },
  {
    "<leader>CT",
    fn("coverage", function(c) c.toggle() end),
    desc = "Toggle",
  },
}

return M
