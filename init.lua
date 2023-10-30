require("fanteria.plugins")

require("fanteria.title.alpha")

require("fanteria.options")
require("fanteria.keymaps")
require("fanteria.autocmd")

function GetLoadedBufs()
  local loaded = {}
  for _, buf in ipairs(vim.split(vim.fn.execute("buffers"), "\n")) do
    if string.len(buf) ~= 0 then
      loaded[tonumber(string.match(buf, "%d+"))] = buf
    end
  end
  print(vim.inspect(loaded))
  return loaded
end

function GetOpenBufs()
  local aux = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    aux[vim.api.nvim_win_get_buf(win)] = true
  end
  return aux
end

function CloseNotOpenBufs()
  local open = GetOpenBufs()
  for bufnr, _ in ipairs(GetLoadedBufs()) do
    if not open[bufnr] then
      vim.cmd("Bdelete " .. bufnr)
    end
  end
end

