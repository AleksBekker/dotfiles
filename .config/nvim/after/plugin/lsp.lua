local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config("pyright", {
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml", "setup.py" }, { upward = true })[1]),
    settings = {
        python = {
            pythonPath = ".venv/bin/python",
            venvPath = ".",
            venv = ".venv",
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "pyright",
    "ruff",
    "isort",
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

        local tele = require("telescope.builtin")
        lsp_map("n", "gd", tele.lsp_definitions, "goto definition")
        lsp_map("n", "<leader>fs", tele.lsp_document_symbols, "document symbols")
        lsp_map("n", "<leader>fS", tele.lsp_dynamic_workspace_symbols, "dynamic symbols")
        lsp_map("n", "<leader>ft", tele.lsp_type_definitions, "goto type")
        lsp_map("n", "<leader>fr", tele.lsp_references, "goto references")
        lsp_map("n", "<leader>fi", tele.lsp_implementations, "goto implementation")
    end,
})
