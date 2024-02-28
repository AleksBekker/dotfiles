return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
				},
			})

			local builtin = require("telescope.builtin")

			require("scripts").set_mappings({
        mode = "n",
				prefix = "<leader>f",

        ["/"] = { fn = builtin.current_buffer_fuzzy_find, desc = "Find within buffer" },
        b = { fn = builtin.buffers, desc = "Find buffers" },
        c = { fn = builtin.grep_string, desc = "Find word under cursor" },
        C = { fn = builtin.commands, desc = "Find commands" },
        f = { fn = builtin.find_files, desc = "Find files" },
        F = {
          fn = function()
            builtin.find_files({ hidden = true })
          end,
          desc = "Find all files",
        },
        g = { fn = builtin.live_grep, desc = "Live grep" },
        h = { fn = builtin.help_tags, desc = "Find help" },
        k = { fn = builtin.keymaps, desc = "Find keymap" },
        m = { fn = builtin.man_pages, desc = "Find man pages" },
        T = {
          fn = function()
            builtin.colorscheme({ enable_preview = true })
          end,
          desc = "Find colorscheme",
        },
      })

			-- TODO: implement these functions once available
			-- vim.keymap.set('n', '<leader>fn', <NOTIFICATION FUNCTION HERE>, { desc = 'Find notifications' })

			-- FIX: These mappings don't work
			-- vim.keymap.set('n', '<leader>f<CR>', builtin.man_pages, { desc = 'Resume search' })
			-- vim.keymap.set('n', '<leader>fo', builtin.<HISTORY FUNCTION HERE>, { desc = 'History' })
			-- vim.keymap.set('n', '<leader>fT', <THEME FUNCTION HERE>, { desc = 'Find themes' })
			-- vim.keymap.set('n', '<leader>fG',
			-- function() builtin.live_grep({ hidden = true }) end, { desc = 'Live grep all files' })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
