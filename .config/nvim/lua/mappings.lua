local scripts = require("scripts")

scripts.set_mappings({
	mode = "i",

	["jk"] = { keys = "<Esc>" },
	-- ["<C-s>"] = { keys = "<Esc>:w<CR>", desc = "Save" },
})

require("scripts").set_mappings({
	mode = "n",
	prefix = "<leader>",
	c = { command = "bdelete", desc = "Close current buffer" },
	C = { command = "bdelete!", desc = "Force close current buffer" },
	e = { fn = vim.cmd.Ex, desc = "File Explorer" },
	n = { command = "tabe", desc = "Open file in new tab" },
	q = { command = "q", desc = "Quit" },
	Q = { command = "q!", desc = "Force quit" },
	w = { command = "w", desc = "Write current buffer" },
	W = { command = "W", desc = "Force write current buffer" },

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

require("scripts").set_mappings({
	mode = "n",

	H = { command = "bprev", desc = "Go to previous buffer" },
	L = { command = "bnext", desc = "Go to next buffer" },
	-- ["<C-S>"] = { command = "w", desc = "Save current buffer" },

	-- LEARN HOW TO NOT USE THESE
	-- ["<C-h>"] = { keys = "<C-w>h" },
	-- ["<C-j>"] = { keys = "<C-w>j" },
	-- ["<C-k>"] = { keys = "<C-w>k" },
	-- ["<C-l>"] = { keys = "<C-w>l" },
})
