vim.g.mapleader = ' '

require("scripts").set_options({
  o = {
    timeout = true,
    timeoutlen = 500,

    smartindent = true,
    expandtab = true,
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,

    relativenumber = true,
    number = true,
    mouse = 'a',

    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.cache/nvim_undodir",
    undofile = true,

    hlsearch = false,
    incsearch = true,

    termguicolors = true,

    scrolloff = 8,
    signcolumn = "yes",
    colorcolumn = "121",

    wrap = false,

    updatetime = 50,
  },
  g = {
    ftplugin_sql_omni_key = '<C-j>',
  },
})
