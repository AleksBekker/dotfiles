local function get_opts(key_table)
  return {
    buffer = key_table["buffer"],
    desc = key_table["desc"],
    silent = key_table["silent"],
  }
end

local function get_action(key_table)
  local command = nil
  if key_table["command"] ~= nil then
    command = function()
      vim.cmd(key_table["command"])
    end
  end

  return key_table["fn"] or command or key_table["keys"]
end

-- Set mappings within a mode
local function set_mode_mappings(mode, prefix, mode_mappings)
  for partial_trigger, key_table in pairs(mode_mappings) do
    local action = get_action(key_table)
    local opts = get_opts(key_table)
    local trigger = prefix .. partial_trigger

    vim.keymap.set(mode, trigger, action, opts)
  end
end

-- Table returned from this module
local M = {}

-- Set mappings from a table
M.set_mappings = function(mappings)
  local prefix = mappings["prefix"] or ""
  mappings["prefix"] = nil

  local overall_mode = mappings["mode"]
  mappings["mode"] = nil
  if overall_mode ~= nil then
    set_mode_mappings(overall_mode, prefix, mappings)
    return
  end

  for mode, mode_mappings in pairs(mappings) do
    set_mode_mappings(mode, prefix, mode_mappings)
  end
end

-- Set options from a table
M.set_options = function(option_table)
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

-- Set options from a table per filetype
M.set_filetype_options = function(ft_table)
  for filetype, option_table in pairs(ft_table) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function()
        M.set_options(option_table)
      end,
    })
  end
end

return M
