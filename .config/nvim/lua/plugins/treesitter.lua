return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = { "lua" },
      highlight = { enable = true },
      indent = { enable = true },
    })

    require("scripts").set_mappings({
      mode = "n",
      ["<leader>ic"] = { command = "TSContextToggle", desc = "Toggle context" },
    })
  end,
}
