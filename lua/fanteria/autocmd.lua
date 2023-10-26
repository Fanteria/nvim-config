vim.api.nvim_create_autocmd({"TextYankPost"}, {
  callback = function (_)
    require("vim.highlight").on_yank({higroup = "Visual", timeout = 200})
  end
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  callback = function (_)
    vim.cmd("set formatoptions-=cro") -- don't add comments on new lines
  end
})

vim.api.nvim_create_autocmd({"VimResized"}, {
  callback = function (_)
    local tabpage = vim.api.nvim_get_current_tabpage()
    vim.cmd("let savetab = tabpagenr() | tabdo wincmd = | execute 'tabnext' savetab")
  end
})

vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = "*.*",
  callback = function (_)
    vim.cmd("mkview")
  end
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = "*.*",
  callback = function (_)
    vim.cmd("silent! loadview")
  end
})

-- autocmd BufReadPre * if &ff == '' | set ff=dos | endif
-- :set fileformat?
