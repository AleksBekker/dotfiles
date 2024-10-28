---Get the options to pass to `vim.keymap.set` from a table
---@param key_table table<string, string | function>
---@return table<string, string | function>
local function get_opts(key_table)
  return {
    buffer = key_table["buffer"],
    desc = key_table["desc"],
    silent = key_table["silent"],
  }
end

---Get the action to pass to `vim.keymap.set` from a table
---@param key_table table<string, string | function>
---@return string | function
local function get_action(key_table)
  local command = nil
  if key_table["command"] ~= nil then
    command = function()
      vim.cmd(key_table["command"])
    end
  end

  return key_table["fn"] or command or key_table["keys"]
end

---Set mappings within a mode
---@param mode string
---@param prefix string
---@param mode_mappings table<string, table<string, string | function>>
local function set_mode_mappings(mode, prefix, mode_mappings)
  for partial_trigger, key_table in pairs(mode_mappings) do
    local action = get_action(key_table)
    local opts = get_opts(key_table)
    local trigger = prefix .. partial_trigger

    vim.keymap.set(mode, trigger, action, opts)
  end
end

---Table returned from this module
local M = {}

---Set mappings from a table
---TODO: figure out how to type this function's argument without absolutely destroying the type checker
function M.set_mappings(mappings)
  local prefix = mappings["prefix"] or ""
  mappings["prefix"] = nil

  if mappings["mode"] ~= nil then
    local mode = mappings["mode"]
    mappings["mode"] = nil
    mappings = {
      [mode] = mappings
    }
  end

  for mode, mode_mappings in pairs(mappings) do
    set_mode_mappings(mode, prefix, mode_mappings)
  end
end

---Set options from a table
---@param option_table table<string, table<string, any>>
function M.set_options(option_table)
  local option_spaces = {
    g = vim.g,
    o = vim.o,
  }

  for label, options in pairs(option_table) do
    local option_space = option_spaces[label]

    for option, value in pairs(options) do
      option_space[option] = value
    end
  end
end

---Set options from a table per filetype
---@param ft_table table<string, table<string, table<string, any>>>
function M.set_filetype_options(ft_table)
  for filetype, option_table in pairs(ft_table) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function()
        M.set_options(option_table)
      end,
    })
  end
end

---@param ... table<any, any> tables to merge. Later tables overwrite earlier ones.
---@return table<any, any>
function M.merge(...)
  local tables = {...}
  local merged = {}

  for _, table in ipairs(tables) do
    for key, value in pairs(table) do
      merged[key] = value
    end
  end

  return merged
end

return M
