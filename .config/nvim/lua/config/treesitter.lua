
require'nvim-treesitter.configs'.setup {

    -- List of parser names
    ensure_installed = { 'lua', 'rust' },

    -- Install parsers syncronously
    sync_install = false,

    -- List of parsers to ignore installing, if `ensure_installed` is `all`
    -- ignore_install = { },
    
    highlight = {
        enable = true, -- `false` disables the extension
        disable = { },
        additional_vim_regex_highlighting = false,
    }
}

