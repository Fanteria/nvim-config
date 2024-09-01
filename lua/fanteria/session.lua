local M = {}

M.actual_session = ""

--- Path where sessions will be stored. Path is `$HOME/.nvim-sessions/`.
---@return table | nil Path to sessions.
local function get_parent_folder()
  local Path_ok, Path = pcall(require, "plenary.path")
  if not Path_ok then
    vim.notify("Plenary cannot be loaded.")
    return nil
  end

  -- if folder does not exists will be created
  local session_filepath = "~/.nvim-sessions"
  return Path:new(vim.fn.expand(session_filepath, ":p"))
end

--- Save actual state as new session or update actual session
--- if given name is empty.
---@return boolean True is session has been saved.
function M.save()
  local filename = vim.fn.input("Enter session name: ")
  if filename == "" then
    if M.actual_session == "" then
      print("There is no active session.")
      return false
    end
    filename = M.actual_session
  end
  local parent_folder = get_parent_folder()
  if parent_folder == nil then
    return false
  end
  vim.fn.mkdir(parent_folder.filename, "p")
  local absolute_path = parent_folder:joinpath(filename .. ".session")
  vim.cmd("mksession! " .. absolute_path.filename)
  M.actual_session = filename
  return true
end

--- Open telescope window with sessions. Selected session will be loaded.
---@param opts ?table Telescope options.
function M.load(opts)
  local scandir_ok, scandir = pcall(require, "plenary.scandir")
  if not scandir_ok then
    vim.notify("Plenary cannot be loaded.", vim.log.levels.ERROR)
    return
  end

  opts = opts or {}
  local parent_folder = get_parent_folder()
  if parent_folder == nil then
    return
  end
  vim.fn.mkdir(parent_folder.filename, "p")
  local session_paths = scandir.scan_dir(parent_folder.filename, { depth = 1, search_pattern = ".session" })
  local names = {}
  for _, session_path in ipairs(session_paths) do
    local filename = session_path:match("[^/]+$")
    local name = filename:gsub("%.session$", "")
    table.insert(names, name)
  end

  require("fanteria.utils.telescope").open_selection("Sessions", names, function(selected)
    M.actual_session = selected
    local path = parent_folder:joinpath(selected .. ".session")
    vim.cmd("silent! source " .. path.filename)
  end)
end

local fn = require("utils").fn
--- Keymaps
M.keys = {
  { "<leader>S", group = "Sessions" },

  {
    "<leader>SL",
    fn("telescope.themes", function(t) M.load(t.get_dropdown({})) end),
    desc = "Load",
  },
  {
    "<leader>SS",
    M.save,
    desc = "Save",
  },
  {
    "<leader>SA",
    function()
      if M.actual_session == "" then
        vim.notify("There is no active session")
      else
        vim.notify(M.actual_session)
      end
    end,
    desc = "Actual session",
  },
}

return M
