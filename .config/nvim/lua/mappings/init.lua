local utils = require("utils")
local commands = require("mappings.commands")

utils.set_mappings({
  mode = "i",

  ["jk"] = { keys = "<Esc>" },
})

require("utils").set_mappings({
  mode = "n",
  prefix = "<leader>",
  c = { command = "bdelete", desc = "Close current buffer" },
  C = { command = "bdelete!", desc = "Force close current buffer" },
  -- e = { fn = vim.cmd.Ex, desc = "File Explorer" },
  n = { command = "tabe", desc = "Open file in new tab" },
  q = { command = "q", desc = "Quit" },
  Q = { command = "q!", desc = "Force quit" },
  w = { fn = commands.write, desc = "Write current buffer" },
  W = { fn = commands.force_write, desc = "Force write current buffer" },

  -- TODO: might wanna move some of these to the LSP config
  ["pi"] = { command = "Lazy install", desc = "Open Lazy's 'install' page" },
  ["pl"] = { command = "LspInstall", desc = "Install LSP" },
  ["pM"] = { command = "MasonUpdate", desc = "Mason update" },
  ["pm"] = { command = "Mason", desc = "Open Mason" },
  ["pS"] = { command = "Lazy sync", desc = "Sync Lazy packages" },
  ["ps"] = { command = "Lazy", desc = "Open Lazy" },
  ["pu"] = { command = "Lazy update", desc = "Update Lazy packages" },

  ["iw"] = {
    fn = function()
      vim.o.wrap = not vim.o.wrap
    end,
    desc = "Toggle wrap",
  },
})

require("utils").set_mappings({
  mode = "n",

  H = { command = "bprev", desc = "Go to previous buffer" },
  L = { command = "bnext", desc = "Go to next buffer" },
})

-- Set colorscheme
require("plugins.catppuccin").set()
