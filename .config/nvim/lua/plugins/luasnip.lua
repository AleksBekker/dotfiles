return {
	"L3MON4D3/LuaSnip",

	config = function()
		local ls = require("luasnip")

		require("utils").set_mappings({
			mode = "i",

			["<C-k>"] = {
				fn = function()
					if ls.expand_or_jumpable() then
						ls.expand_or_jump()
					end
				end,
				desc = "Expand or jump snippets",
			},

			["<C-j>"] = {
				fn = function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					end
				end,
				desc = "Jump backwards in snippet",
			},

			["<C-l>"] = {
				fn = function()
					if ls.choice_active() then
						ls.change_choice(1)
					end
				end,
				desc = "Choose within list in snippet",
			},
		})
	end,
}
