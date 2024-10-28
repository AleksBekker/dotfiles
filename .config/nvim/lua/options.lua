vim.g.mapleader = " "

local utils = require("utils")

utils.set_options({
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

    showmode = false,

		-- Folds
		foldmethod = "expr",
		foldexpr = "v:lua.vim.treesitter.foldexpr()",
		foldcolumn = "0", -- TODO: play around with commenting this out
		foldtext = "", -- TODO: play around with commenting this out
		foldlevel = 99,
		foldlevelstart = 99,
	},
	g = {
		ftplugin_sql_omni_key = "<C-j>",
		c_syntax_for_h = 1,
	},
})

utils.set_filetype_options({
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
	["tex"] = {
		o = {
			colorcolumn = "101",
			spell = true,
			tabstop = 2,
			softtabstop = 2,
			shiftwidth = 2,
		},
	},
	["markdown"] = {
		o = {
			colorcolumn = "101",
			spell = true,
			tabstop = 2,
			softtabstop = 2,
			shiftwidth = 2,
		},
	},
	["sh"] = {
		o = {
			colorcolumn = "81",
			tabstop = 2,
			softtabstop = 2,
			shiftwidth = 2,
		},
	},
	["bash"] = {
		o = {
			colorcolumn = "81",
			tabstop = 2,
			softtabstop = 2,
			shiftwidth = 2,
		},
	},
	["zsh"] = {
		o = {
			colorcolumn = "81",
			tabstop = 2,
			softtabstop = 2,
			shiftwidth = 2,
		},
	},
  ["go"] = {
    o = {
      tabstop = 4,
      softtabstop = 4,
      shiftwidth = 4,
    }
  },
  ["c"] = {
    o = {
      colorcolumn = "81",
      tabstop = 2,
      softtabstop = 2,
      shiftwidth = 2,
    }
  },
  ["haskell"] = {
    o = {
      colorcolumn = "71",
      tabstop = 2,
      softtabstop = 2,
      shiftwidth = 2,
    }
  },
})
