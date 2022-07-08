
local function map(mode, keys, action)
    vim.keymap.set(mode, keys, action, { silent = true })
end

map('n', '<leader>ff', ':Telescope find_files<cr>')
map('n', '<leader>fg', ':Telescope grep_string<cr>')
map('n', '<leader>fb', ':Telescope buffers<cr>')

