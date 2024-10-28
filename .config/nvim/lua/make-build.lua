M = {}

---@param array table<any> Table to append to
---@param value any value to append
local function append(array, value)
  array[#array + 1] = value
end

---@param path string the path to the Makefile
---@returns array of commands if successful, nil otherwise
function M.find_commands(path)
  local shell_command = "awk -F':' '/^[a-zA-Z0-9][^$#\\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' " ..
      path

  local handle = io.popen(shell_command, "r")
  if handle == nil then
    return nil
  end

  local commands = {}
  for line in handle:lines() do
    append(commands, line)
  end
  handle:close()

  return commands
end

---@param path string path to the makefile
---@param opts table<string, any> options for this function
---@param picker function the function that determines the selection
---@param picker_opts table<any, any> options for the picker
function M.pick_command(path, opts, picker, picker_opts)
  local commands = M.find_commands(path) or {}

  if opts["sorted"] then
    table.sort(commands)
  end

  return picker(commands, picker_opts)
end

M.pickers = {}

-- TODO: figure out how to do this without on_complete
-- ---@param options table<string> the options for the selection
-- ---@param on_complete function function run after a selection is made
-- function M.pickers.native(options, on_complete)
--   vim.ui.select(
--     options,
--     { prompt = "Select a make configuration:" },
--     function(choice, _) on_complete(choice) end
--   )
-- end

---@param choices table<string> the user's choices
---@param opts table<any, any> the table passed to the new picker, except that opts["opts"] is used as the internal opts for the other telescope components.
function M.pickers.telescope(choices, opts)
  local tele_pickers = require("telescope.pickers")
  local tele_finders = require("telescope.finders")
  local tele_config = require("telescope.config").values

  local inner_opts = opts["opts"] or {}

  opts = require("utils").merge({
      prompt_title = "Select a make configuration:",
      sorter = tele_config.generic_sorter(inner_opts),
    },
    opts,
    {
      opts = nil,
      finder = tele_finders.new_table { results = choices },
    })

  for key, value in pairs(opts) do
    print(key, value)
  end

  tele_pickers.new(inner_opts, opts):find()
end

local choice = M.pick_command("NvimMakefile", {sorted=false}, M.pickers.telescope, {})
print(choice)

return M
