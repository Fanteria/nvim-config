local M = {}

M.opts = {
  lang = {
    rust = {
      coverage_command = "grcov ${cwd} -s ${cwd} --binary-path ./target/debug/ -t coveralls --branch --ignore-not-existing --token NO_TOKEN --llvm-path /usr/bin"
    },
  },
}

M.setup = function (_, opts)
  require("coverage").setup(opts)
end

return M
