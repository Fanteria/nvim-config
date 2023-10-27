local status_ok, sessions = pcall(require, "sessions")
if not status_ok then
	return
end

-- TODO can be reworked??

local session_filepath = "~/.nvim-sessions"

sessions.setup({
	events = { "VimLeavePre" },
	session_filepath = session_filepath,
	absolute = true,
})

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local plenary_scan = require("plenary.scandir")
local Path = require("plenary.path")

local parent_folder = Path:new(vim.fn.expand(session_filepath, ":p"))
local actual_session = ""

SessionSave = function()
  local filename = vim.fn.input("Enter session name: ")
  if filename == "" then
    if actual_session == "" then
      print("There is no active session.")
      return false
    end
    filename = actual_session
  end
  local absolute_path = parent_folder:joinpath(filename .. ".session")
  sessions.save(absolute_path.filename, { autosave = false, silent = false })
  return true
end

-- Telescope menu for loading session from `parent_folder` (`parent_folder` must be set)
SessionLoad = function(opts)
	opts = opts or {}
	local session_paths = plenary_scan.scan_dir(parent_folder.filename, { depth = 1, search_pattern = ".session" })
	local names = {}
	for _, session_path in ipairs(session_paths) do
		local filename = session_path:match("[^/]+$")
		local name = filename:gsub("%.session$", "")
		table.insert(names, name)
	end

	pickers
		.new(opts, {
			prompt_title = "Sessions",
			finder = finders.new_table({ results = names }),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()[1]
          actual_session = selection
					local path = parent_folder:joinpath(selection .. ".session")
					sessions.load(path.filename, { autosave = false, silent = false })
				end)
				return true
			end,
		})
		:find()
end

