local M = {}

local function writer(buf, force)
  local path = vim.api.nvim_buf_get_name(buf)

  if path == "" then
    vim.ui.input({ prompt = "New filename: " }, function(input)
      path = input
    end)
  end

  if path ~= nil then
    vim.cmd.write({ args = { path }, bang = force })
  end
end

M.write = function()
  writer(0, false)
end

M.force_write = function()
  writer(0, true)
end

return M
