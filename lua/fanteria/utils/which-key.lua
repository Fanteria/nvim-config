local M = {}

M.get_mappings = function()
  local telescope = require("telescope.builtin")
  local map = {}

  local neogen_ok, neogen = pcall(require, "neogen")
  if neogen_ok then
    map.d = {
      name = "Documentation",
      c = { function() neogen.generate({ type = 'class' }) end, "Class" },
      f = { function() neogen.generate({ type = 'func' }) end, "Function" },
      t = { function() neogen.generate({ type = 'type' }) end, "Type" },
      F = { function() neogen.generate({ type = 'file' }) end, "File" },
    }
  end

  local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
  if gitsigns_ok then
    map.g = {
      name = "Git",
      j = { gitsigns.next_hunk, "Next Hunk" },
      k = { gitsigns.prev_hunk, "Prev Hunk" },
      l = { gitsigns.blame_line, "Blame" },
      p = { gitsigns.preview_hunk, "Preview Hunk" },
      r = { gitsigns.reset_hunk, "Reset Hunk" },
      R = { gitsigns.reset_buffer, "Reset Buffer" },
      s = { gitsigns.stage_hunk, "Stage Hunk" },
      S = { gitsigns.stage_buffer, "Stage Buffer" },
      u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
      U = { gitsigns.undo_stage_buffer, "Undo Stage Buffer" },
      o = { telescope.git_status, "Open changed file" },
      b = { function()
        telescope.git_branches({ show_remote_tracking_branches = false })
      end, "Checkout branch" },
      B = { telescope.git_branches, "Checkout branch with remote" },
      c = { telescope.git_commits, "Checkout commit" },
      d = { gitsigns.diffthis, "Diff" },
    }
  end

  map.u = { function()
    require"telescope".extensions.undo.undo()
    local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.api.nvim_feedkeys(keys, 'm', false)
  end, "Undotree" }

  map.y = { '<cmd>let @+ = expand("%:p")<CR>', "Yank buffer path" }

  map.L = {
    name = "LSP",
    d = { telescope.diagnostics, "Diagnostics" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Installer Info" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.lsp.diagnostic.set_loclist, "Quickfix" },
    p = { "<cmd>TSPlaygroundToggle<CR>", "Treesitter playground" },
    s = { telescope.lsp_document_symbols, "Document Symbols" },
    S = {
      telescope.lsp_dynamic_workspace_symbols,
      "Workspace Symbols",
    },
  }

  map.O = { "<cmd>execute '!xdg-open' shellescape(expand('<cfile>', 1))<CR>", "Open path" }

  map.S = {
    name = "Sessions",
    L = { function()
      require("fanteria.session").load(require("telescope.themes").get_dropdown({}))
    end, "Load" },
    S = { require("fanteria.session").save, "Save" }
  }

  map.W = { require("fanteria.visual.indent-blankline").toggle_whitespaces, "Toggle whitespaces" }

  map.X = {
    name = "Options",
    c = { telescope.colorscheme, "Colorscheme" },
    h = { telescope.help_tags, "Find Help" },
    m = { telescope.man_pages, "Man Pages" },
    r = { telescope.oldfiles, "Open Recent File" },
    R = { telescope.registers, "Registers" },
    k = { telescope.keymaps, "Keymaps" },
    C = { telescope.commands, "Commands" },
    L = { "<cmd>Lazy<CR>", "Lazy" },
  }

  return map
end

M.opts = {
  ignore_missing = true,
}

M.setup = function(_, opts)
  local which_key = require("which-key")

  which_key.setup(opts)
  which_key.register(M.get_mappings(), { prefix = "<leader>", nowait = true })
end

return M
