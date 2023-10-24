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
  extensions = {
    undo = {
      mappings = {
        i = {
          ["yy"] = require("telescope-undo.actions").yank_additions,
          ["yd"] = require("telescope-undo.actions").yank_deletions,
          ["<cr>"] = require("telescope-undo.actions").restore,
        },
        n = {
          ["yy"] = require("telescope-undo.actions").yank_additions,
          ["yd"] = require("telescope-undo.actions").yank_deletions,
          ["<cr>"] = require("telescope-undo.actions").restore,
        },
      },
    },
  },
})
telescope.load_extension("undo")

local project_ok, project = pcall(require, "project_nvim")
if project_ok then
  project.setup({
    detection_methods = { "pattern" },
  })
  telescope.load_extension('projects')
end
