local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            pythonPath = ".venv/bin/python",
            venvPath = ".",
            venv = ".venv",
        },
    },
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

vim.lsp.config("ts_ls", {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = true,
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local lsp_map = function(modes, keys, func, desc)
            vim.keymap.set(modes, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        lsp_map("n", "K", vim.lsp.buf.hover, "hover")
        lsp_map("n", "<leader>E", vim.diagnostic.open_float, "diagnostic")
        lsp_map("n", "<leader>k", vim.lsp.buf.signature_help, "signature help")
        lsp_map("n", "<leader>rn", vim.lsp.buf.rename, "rename")
        lsp_map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "code action")
        lsp_map("n", "<leader>lf", vim.lsp.buf.format, "format")
        lsp_map("n", "<leader>ld", vim.diagnostic.setqflist, "diagnostics")

        local tele = require("telescope.builtin")
        lsp_map("n", "gd", tele.lsp_definitions, "goto definition")
        lsp_map("n", "<leader>fs", tele.lsp_document_symbols, "document symbols")
        lsp_map("n", "<leader>fS", tele.lsp_dynamic_workspace_symbols, "dynamic symbols")
        lsp_map("n", "<leader>ft", tele.lsp_type_definitions, "goto type")
        lsp_map("n", "<leader>fr", tele.lsp_references, "goto references")
        lsp_map("n", "<leader>fi", tele.lsp_implementations, "goto implementation")
    end,
})
