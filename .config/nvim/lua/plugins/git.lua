return {
	{
		"tpope/vim-fugitive",
		config = function()
			require("scripts").set_mappings({
				mode = "n",
				prefix = "<leader>g",

        b = { command = "Git blame", desc = "Git blame" },
				g = { fn = vim.cmd.Git,  desc = "Git fugitive status" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			require("scripts").set_mappings({
				mode = "n",
				prefix = "<leader>g",

        d = { command = "Gdiffsplit", desc = "Show file diff" },
				l = { command = "Gitsigns toggle_current_line_blame", desc = "Toggle git blame" },
				p = { command = "Gitsigns preview_hunk", desc = "Gitsigns preview" },
			})
		end,
	},
}
