return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>iz", require("zen-mode").toggle, { desc = "Toggle zen mode" } )
  end
}
