-- Key mapping function
local function map(mode, keys, action)
    vim.keymap.set(mode, keys, action, { silent = true })
end

-- Escape keys
map('i', 'jk', '<esc>')
map('v', 'jk', '<esc>')

-- Save/exit functions
map('n', '<C-s>', ':up<CR>')
map('n', '<C-q>', ':up|q!<CR>')
map('n', '<C-x>', ':q!<CR>')

map('i', '<C-s>', '<esc>:up<CR>')
map('i', '<C-q>', '<esc>:up|q!<CR>')
map('i', '<C-x>', '<esc>:q!<CR>')

-- Tab controls
map('n', '<tab>', 'gt')
map('n', '<s-tab>', 'gT')
map('n', '<c-t>', ':tabe<enter>')

-- Better visual mode indentation
map('v', '<', '<gv')
map('v', '>', '>gv')

