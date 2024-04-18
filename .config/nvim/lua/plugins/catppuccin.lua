-- Toggle light vs. dark mode
local function toggle_background()
  local opposites = { light = "dark", dark = "light" }
  vim.o.background = opposites[vim.o.background] or "dark"
end

-- Toggle transparency
local function toggle_transparency()
  local cat = require("catppuccin")
  cat.options.transparent_background = not cat.options.transparent_background
  cat.compile()
  vim.cmd.colorscheme("catppuccin")
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  dependencies = {
    "j-hui/fidget.nvim",
  },
  config = function()
    local cat = require("catppuccin")

    cat.setup({
      transparent_background = true,
      background = { light = "latte", dark = "mocha" },
      integrations = {
        fidget = true,
        harpoon = true,
      },
    })
  end,
  set = function()
    require("utils").set_mappings({
      mode = "n",
      prefix = "<leader>i",
      b = { fn = toggle_background, desc = "Toggle background" },
      t = { fn = toggle_transparency, desc = "Toggle transparency" },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
