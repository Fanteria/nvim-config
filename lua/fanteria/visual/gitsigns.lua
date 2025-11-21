local M = {}

--- Git signs options.
M.opts = {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
}

local fn = require("utils").fn
--- Keymaps.
M.keys = {
  { "<leader>g", group = "Git" },
  {
    "<leader>gj",
    fn("gitsigns", function(g) g.nav_hunk("next", { wrap = true }) end),
    desc = "Next hunk",
  },
  {
    "<leader>gk",
    fn("gitsigns", function(g) g.nav_hunk("prev", { wrap = true }) end),
    desc = "Prev Hunk",
  },
  {
    "<leader>gl",
    fn("gitsigns", function(g) g.blame_line() end),
    desc = "Blame",
  },
  {
    "<leader>gp",
    fn("gitsigns", function(g) g.preview_hunk() end),
    desc = "Preview Hunk",
  },
  {
    "<leader>gr",
    fn("gitsigns", function(g) g.reset_hunk() end),
    desc = "Preview Hunk",
  },
  {
    "<leader>gR",
    fn("gitsigns", function(g) g.reset_buffer() end),
    desc = "Reset Buffer",
  },
  {
    "<leader>gs",
    fn("gitsigns", function(g) g.stage_hunk() end),
    desc = "Stage Hunk",
  },
  {
    "<leader>gS",
    fn("gitsigns", function(g) g.stage_buffer() end),
    desc = "Stage Buffer",
  },
  {
    "<leader>gu",
    fn("gitsigns", function(g) g.undo_stage_hunk() end),
    desc = "Undo Stage Hunk",
  },
  {
    "<leader>gU",
    fn("gitsigns", function(g) g.undo_stage_buffer() end),
    desc = "Undo Stage Buffer",
  },
  {
    "<leader>go",
    fn("telescope.builtin", function(t) t.git_status() end),
    desc = "Open changed file",
  },
  {
    "<leader>gb",
    fn("telescope.builtin", function(t) t.git_branches({ show_remote_tracking_branches = false }) end),
    desc = "Checkout branch",
  },
  {
    "<leader>gB",
    fn("telescope.builtin", function(t) t.git_branches() end),
    desc = "Checkout branch with remote",
  },
  {
    "<leader>gC",
    fn("telescope.builtin", function(t) t.git_commits() end),
    desc = "Checkout commit",
  },
  {
    "<leader>gd",
    fn("gitsigns", function(g) g.diffthis() end),
    desc = "Diff",
  },
  {
    "<leader>gD",
    function()
      vim.cmd("Gvdiffsplit " .. vim.fn.input("Enter branch to diff: "))
    end,
    desc = "Diff branch",
  },
  {
    "<leader>gm",
    "<cmd>vertical Git<CR>",
    desc = "Git status vertical",
  },
  {
    "<leader>gM",
    "<cmd>Git<CR>",
    desc = "Git status horizontal",
  },
  {
    "<leader>gL",
    "<cmd>Git log<CR>",
    desc = "Git log",
  },
  {
    "<leader>gc",
    "<cmd>Git commit<CR>",
    desc = "Git commit",
  },
}

return M
