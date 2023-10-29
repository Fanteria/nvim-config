local M = {}

local header = {
	[[                                      ]],
	[[ _____           _            _       ]],
	[[|  ___|_ _ _ __ | |_ ___ _ __(_) __ _ ]],
	[[| |_ / _` | '_ \| __/ _ \ '__| |/ _` |]],
	[[|  _| (_| | | | | ||  __/ |  | | (_| |]],
	[[|_|  \__,_|_| |_|\__\___|_|  |_|\__,_|]],
}

local footer = {
	[[Most good programmers do programming]],
	[[not because they expect to get paid]],
	[[or get adulation by the public, ]],
	[[but because it is fun to program.]],
	[[]],
	[[ Linus Torvalds]],
}

M.setup = function(_, _)
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = header

dashboard.section.buttons.val = {
	{ type = "padding", val = 1 },
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "󱪝  Open file", ":Telescope find_files <CR>"),
	dashboard.button("p", "  Open project", ":Telescope projects <CR>"),
  dashboard.button("s", "  Open session", ":lua require('fanteria.session').load() <CR>"),
	dashboard.button("r", "󱋡  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
	{ type = "padding", val = 3 },
}

dashboard.section.footer.val = footer

dashboard.section.header.opts.hl = "Include"
dashboard.opts.opts.noautocmd = true
require("alpha").setup(dashboard.config)
end

return M
