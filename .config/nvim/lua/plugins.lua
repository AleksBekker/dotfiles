
-- Remove if packer not configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer').startup(function()

    -- Packer
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope.nvim'

    -- Auto pairs

    -- Colorschemes
    use 'morhetz/gruvbox'

end)

---- SOURCE PLUGIN CONFIGS ----

require 'config.treesitter'
require 'config.telescope'
require 'config.lspconfig'

---- IMPORTANT: THIS MUST BE THE LAST LINE IN THE FILE ----

return packer

