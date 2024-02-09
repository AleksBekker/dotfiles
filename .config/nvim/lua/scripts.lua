local function get_opts(key_table)
  return {
    desc = key_table["desc"],
    buffer = key_table["buffer"],
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

return {
  -- set mappings from a table
  set_mappings = function(mappings)
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
  end,

  -- set options from a table
  set_options = function(option_table)
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
  end,
}
