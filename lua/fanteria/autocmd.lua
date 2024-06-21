vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function(_)
    require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
  end
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function(_)
    vim.cmd("set formatoptions-=cro") -- don't add comments on new lines
  end
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function(_)
    vim.cmd("let savetab = tabpagenr() | tabdo wincmd = | execute 'tabnext' savetab")
  end
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = "*.*",
  callback = function(_)
    vim.cmd("mkview")
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "/etc/mongodb.conf" },
  callback = function()
    vim.cmd("set filetype=yaml")
  end
})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  pattern = '*',
  callback = function ()
    if (vim.fn.getfsize(vim.fn.expand("%")) > 2000000) then
      vim.b.is_large_buffer = true
      vim.cmd("syntax off")
      vim.cmd("IBLDisable")
      vim.cmd("ILLUMINATEPAUSEBUF")
    else
      vim.b.is_large_buffer = false
    end
  end,
})

-- Solve problem with tabs jumps to random places because of LuaSnip.
-- https://github.com/L3MON4D3/LuaSnip/issues/258
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function ()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldtext = [[luaeval('HighlightedFoldtext')()]]
    else
      vim.wo.foldmethod = "syntax"
    end
  end
})

