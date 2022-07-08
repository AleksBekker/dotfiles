
local function map(mode, keys, action)
    vim.keymap.set(mode, keys, action, { silent = true })
end

local on_attach = function(client, bufnr)
    -- Completion (triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- go to different parts of the code
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)

    -- workspace stuff
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)

    -- editing the code
    map('n', '<F2>', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>f', vim.lsp.buf.formatting, bufopts) -- NOTE: INTERFERES WITH TELESCOPE KEYBINDS

    -- not sure what this does
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

end

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true
            },
        }
    }
}

