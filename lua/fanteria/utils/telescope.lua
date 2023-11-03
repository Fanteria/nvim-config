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
      use_delta = true,
      diff_context_lines = 9,
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.7,
      },
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

  telescope.setup(opts)

  telescope.load_extension("undo")
  require("project_nvim").setup({
    detection_methods = { "pattern" },
  })
  telescope.load_extension('projects')
end

return M
