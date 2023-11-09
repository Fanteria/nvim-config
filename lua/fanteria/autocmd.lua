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

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*.*",
  callback = function(_)
    vim.cmd("silent! loadview")
  end
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
