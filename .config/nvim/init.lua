-- lazy.nvim installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- get all required files
require("options")
require("lazy").setup("plugins", {})
require("mappings")

local autocmd = vim.api.nvim_create_autocmd
autocmd("LspAttach", {

	callback = function(e)
		local set_mappings = require("scripts").set_mappings

		set_mappings({
			mode = "n",

			K = { fn = vim.lsp.buf.hover, desc = "Show help for identifier", buffer = e.buf },
			["gd"] = { fn = vim.lsp.buf.definition, "Go to definition", buffer = e.buf },
			["gD"] = { fn = vim.lsp.buf.declaration, "Go to declaration", buffer = e.buf },
			["gT"] = { fn = vim.lsp.buf.type_definition, "Go to type definition", buffer = e.buf },
			["[d"] = { fn = vim.diagnostic.goto_prev, desc = "Go to previous diagnostic", buffer = e.buf },
			["]d"] = { fn = vim.diagnostic.goto_next, desc = "Go to next diagnostic", buffer = e.buf },
		})

		set_mappings({
			mode = "n",
			prefix = "<leader>l",

			a = { fn = vim.lsp.buf.code_action, desc = "Show code actions", buffer = e.buf },
			d = { fn = vim.diagnostic.open_float, desc = "Show line diagnostics", buffer = e.buf },
			f = { fn = vim.lsp.buf.format, desc = "Format current buffer", buffer = e.buf },
			r = { fn = vim.lsp.buf.rename, desc = "Rename identifier", buffer = e.buf },
			R = { fn = vim.lsp.buf.references, desc = "Go to references", buffer = e.buf },
			w = { fn = vim.lsp.buf.workspace_symbol, desc = "Workspace symbol", buffer = e.buf },
		})

    local tele_builtin = require("telescope.builtin")
		set_mappings({
			mode = "n",
			prefix = "<leader>f",

      r = { fn = tele_builtin.lsp_references, desc = "Find references" },
      i = { fn = tele_builtin.lsp_implementations, desc = "Find implementations" },
		})
	end,
})
