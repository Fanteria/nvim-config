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

return M
