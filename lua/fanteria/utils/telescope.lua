local telescope_ok, telescope = pcall(require, "telescope")
local actions_ok, actions = pcall(require, "telescope.actions")
if not telescope_ok or not actions_ok then
  return
end

telescope.setup ({
  defaults = {
    prompt_prefix = "󰍉 ",
    selection_caret = "  ",
    path_display = { "smart" },
    mappings = {
      i = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
      },
      n = {
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["J"] = actions.toggle_selection + actions.move_selection_better,
        ["K"] = actions.toggle_selection + actions.move_selection_worse,
      },
    }
  },
})
telescope.load_extension("undo") -- TODO how to select item in history??

local project_ok, project = pcall(require, "project_nvim")
if project_ok then
  project.setup({
    detection_methods = { "pattern" },
  })
  telescope.load_extension('projects')
end
