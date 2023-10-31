local M = {}

M.opts = {
	check_ts = true,
}

M.setup = function(_, opts)
  require("nvim-autopairs").setup(opts)

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
