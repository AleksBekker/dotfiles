vim.g.mapleader = " "

local scripts = require("scripts")

scripts.set_options({
  o = {
    timeout = true,
    timeoutlen = 500,

    smartindent = true,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,

    relativenumber = true,
    number = true,
    mouse = "a",

    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.cache/nvim_undodir",
    undofile = true,

    hlsearch = false,
    incsearch = true,

    termguicolors = true,

    scrolloff = 8,
    signcolumn = "yes",

    wrap = false,

    updatetime = 50,
  },
  g = {
    ftplugin_sql_omni_key = "<C-j>",
    c_syntax_for_h = 1,
  },
})

scripts.set_filetype_options({
  ["rust"] = {
    o = {
      colorcolumn = "101",
    },
  },
  ["python"] = {
    o = {
      colorcolumn = "121",
    },
  },
  ["lua"] = {
    o = {
      tabstop = 2,
      softtabstop = 2,
      shiftwidth = 2,
    },
  },
})
