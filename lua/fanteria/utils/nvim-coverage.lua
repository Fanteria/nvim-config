local M = {}

M.opts = {
  lang = {
    rust = {
      coverage_command = "grcov ${cwd} -s ${cwd} --binary-path ./target/debug/ -t coveralls --branch --ignore-not-existing --token NO_TOKEN --llvm-path /usr/bin"
    },
  },
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

M.setup = function (_, opts)
  require("coverage").setup(opts)
end

return M
