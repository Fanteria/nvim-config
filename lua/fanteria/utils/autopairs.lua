local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
  print("Autopairs cannot be loaded.")
	return
end

autopairs.setup({
	check_ts = true,
})

-- TODO somehow solve dependency
-- register to cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
