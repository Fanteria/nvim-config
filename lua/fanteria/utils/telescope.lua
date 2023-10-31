local M = {}

M.opts = {
  defaults = {
    prompt_prefix = "󰍉 ",
    selection_caret = "  ",
    path_display = { "smart" },
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    -- borderchars = {" ", " ", " ", " ", " ", " ", " ", " "},
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.5,
      },
      vertical = {
        prompt_position = "top",
      },
      flex = {
        flip_columns = 120,
      },
    },
  },
}

M.setup = function(_, opts)
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  opts.defaults.mappings = {
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

  opts.extensions = {
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
  }

  telescope.load_extension("undo")
  require("project_nvim").setup({
    detection_methods = { "pattern" },
  })
  telescope.load_extension('projects')

  telescope.setup(opts)
end

return M
