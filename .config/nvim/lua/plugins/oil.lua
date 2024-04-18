return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup()
    require("utils").set_mappings({
      mode = "n",
      ["-"] = { command = "Oil", desc = "Parent directory"},
      ["<leader>e"] = { command = "Oil", desc = "File Explorer"},
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
