local M = {}

--- Open selection and run function if some of options are selected.
---@param title string Selection window title.
---@param options string[] List of options.
---@param to_run fun(string):nil parameter
---@param opts ?table Telescope options.
M.open_selection = function (title, options, to_run, opts)
  opts = opts or {}
  local finders = require("telescope.finders")
  local conf = require("telescope.config")
  local actions = require("telescope.actions")
  local pickers = require("telescope.pickers")
  pickers
      .new(opts, {
        prompt_title = title,
        finder = finders.new_table({ results = options }),
        sorter = conf.values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            local selected_option = require("telescope.actions.state").get_selected_entry()[1]
            actions.close(prompt_bufnr)
            to_run(selected_option)
          end)
          return true
        end,
      })
      :find()
end

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
      vim_diff_opts = { ctxlen = 9 },
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
    ["ui-select"] = {

    },
  }

  telescope.setup(opts)

  telescope.load_extension("undo")
  require("project_nvim").setup({
    detection_methods = { "pattern" },
  })
  telescope.load_extension("ui-select")
  telescope.load_extension("projects")
end

local fn = require("utils").fn
M.keys = {
  {
    "<leader>u",
    fn("telescope", function(t)
      t.extensions.undo.undo()
      local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end),
    desc = "Undotree",
  },
  {
    "<leader>F",
    fn("telescope.builtin", function(t) t.live_grep() end),
    hidden = true,
  },
  {
    "<C-p>",
    fn("telescope.builtin", function(t) t.find_files() end),
    hidden = true,
  },
  {
    "<C-b>",
    fn({"telescope.builtin", "telescope.themes"}, function(r)
      r["telescope.builtin"].buffers(r["telescope.themes"].get_dropdown({ previewer = false }))
    end),
    hidden = true,
  },

  { "<leader>X", group = "Options" },
  {
    "<leader>Xc",
    fn("telescope", function(t) t.colorscheme() end),
    desc = "Colorscheme",
  },
  {
    "<leader>Xh",
    fn("telescope", function(t) t.help_tags() end),
    desc = "Find Help",
  },
  {
    "<leader>Xm",
    fn("telescope", function(t) t.man_pages() end),
    desc = "Man Pages",
  },
  {
    "<leader>Xr",
    fn("telescope", function(t) t.oldfiles() end),
    desc = "Open Recent File",
  },
  {
    "<leader>XR",
    fn("telescope", function(t) t.registers() end),
    desc = "Registers",
  },
  {
    "<leader>Xk",
    fn("telescope", function(t) t.keymaps() end),
    desc = "Keymaps",
  },
  {
    "<leader>XC",
    fn("telescope", function(t) t.commands() end),
    desc = "Commands",
  },
  {
    "<leader>XL",
    "<cmd>Lazy<CR>",
    desc = "Lazy"
  },
}

return M
