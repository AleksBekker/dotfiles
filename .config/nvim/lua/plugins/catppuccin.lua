return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      transparent_background = true,
      background = { light = 'latte', dark = 'frappe' },
    })
    vim.cmd.colorscheme 'catppuccin'
  end,
}
