local M = {}

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

-- "notify-send Neovim 'Running coverage' " ..
-- "&& " ..
-- "CARGO_INCREMENTAL=0 " ..
-- "RUSTFLAGS='-Cinstrument-coverage' " ..
-- "LLVM_PROFILE_FILE='cargo-test-%p-%m.profraw' " ..
-- "cargo test > /dev/null" ..
-- "&& " ..
-- "notify-send Neovim 'Generating report' " ..
-- "&& " ..
-- "grcov ${cwd} -s ${cwd} --binary-path ./target/debug/ -t coveralls --branch --ignore-not-existing --token NO_TOKEN --llvm-path /usr/bin"

local fn = require("utils").fn
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
