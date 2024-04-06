return {
	"ThePrimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		require("utils").set_mappings({
			mode = "n",

			["<leader>a"] = { fn = mark.add_file, desc = "Add file to Harpoon" },
			["<C-e>"] = {
				fn = ui.toggle_quick_menu,
				desc = "Open Harpoon quick_menu",
			},

			["<C-h>"] = {
				fn = function()
					ui.nav_file(1)
				end,
				desc = "Harpoon file 1",
			},
			["<C-j>"] = {
				fn = function()
					ui.nav_file(2)
				end,
				desc = "Harpoon file 2",
			},
			["<C-k>"] = {
				fn = function()
					ui.nav_file(3)
				end,
				desc = "Harpoon file 3",
			},
			["<C-l>"] = {
				fn = function()
					ui.nav_file(4)
				end,
				desc = "Harpoon file 4",
			},
		})
	end,
}
