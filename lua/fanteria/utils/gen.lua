local M = {}

--- Gen options.
M.opts = {
    model = "deepseek-coder-v2:16b",
    retry_map = "<c-r>",
    accept_map = "<c-cr>",
    host = "localhost",
    port = "11434",
    display_mode = "split",
}

--- Setup function.
---@param _ table Plugin data.
---@param opts ?table Options.
function M.setup(_, opts)
  opts = opts or {}
  local gen = require("gen")
  gen.setup(opts)

  gen.prompts["Doc_Comment"] = {
      prompt = "Make doc comment of following function in $filetype. Do not repeat function in reply. Reply only with generated doc comment.\n$text",
      replace = false,
  }

  gen.prompts["Doc_Comment_Short"] = {
      prompt = "Make short doc comment of following function in $filetype. Do not repeat function in reply. Reply only with generated doc comment.\n$text",
      replace = false,
  }
end

--- Keymaps.
M.keys = {
  {
    "<leader>A",
    function()
      vim.cmd "Gen"
    end,
    mode = { "n", "v", "x" },
    desc = "AI",
  },
}

return M
