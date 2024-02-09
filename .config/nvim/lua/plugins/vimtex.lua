return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_quickfix_mode = 0
		vim.o.conceallevel = 1
		vim.g.tex_conceal = "abdmg"

		require("scripts").set_mappings({
			mode = "n",
			prefix = "<leader>l",

			c = { keys = "<Plug>(vimtex-compile)", desc = "Compile LaTex" },
			e = { keys = "<Plug>(vimtex-errors)", desc = "Show LaTex Errors" },
		})
	end,
}
