local M = {}

--- Conform options.
M.opts = {
  formatters_by_ft = {
    markdown = { "md_prettier" },
  },
  formatters = {
    md_prettier = {
      command = "prettier",
      args = { "--parser", "markdown" },
      stdin = true,
    },
  },
}

return M
