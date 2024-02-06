local M = {}

local Path_ok, Path = pcall(require, "plenary.path")
local scandir_ok, scandir = pcall(require, "plenary.scandir")
if not Path_ok or not scandir_ok then
  vim.notify("Plenary cannot be loaded.")
  return
end

local pickers_ok, pickers = pcall(require, "telescope.pickers")
local finders_ok, finders = pcall(require, "telescope.finders")
local conf_ok, conf = pcall(require, "telescope.config")
local actions_ok, actions = pcall(require, "telescope.actions")
local action_state_ok, action_state = pcall(require, "telescope.actions.state")
if not pickers_ok or not finders_ok or not conf_ok or not actions_ok or not action_state_ok then
  vim.notify("Telescope cannot be loaded.")
  return
end

-- if folder does not exists will be created
M.session_filepath = "~/.nvim-sessions"
M.parent_folder = Path:new(vim.fn.expand(M.session_filepath, ":p"))
M.actual_session = ""

M.save = function()
  local filename = vim.fn.input("Enter session name: ")
  if filename == "" then
    if M.actual_session == "" then
      print("There is no active session.")
      return false
    end
    filename = M.actual_session
  end
  vim.fn.mkdir(M.parent_folder.filename, "p")
  local absolute_path = M.parent_folder:joinpath(filename .. ".session")
  vim.cmd("mksession! " .. absolute_path.filename)
  M.actual_session = filename
  return true
end

-- Telescope menu for loading session from `parent_folder` (`parent_folder` must be set)
M.load = function(opts)
	opts = opts or {}
  vim.fn.mkdir(M.parent_folder.filename, "p")
	local session_paths = scandir.scan_dir(M.parent_folder.filename, { depth = 1, search_pattern = ".session" })
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
			sorter = conf.values.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()[1]
          M.actual_session = selection
					local path = M.parent_folder:joinpath(selection .. ".session")
          vim.cmd("silent! source " .. path.filename)
				end)
				return true
			end,
		})
		:find()
end

return M
