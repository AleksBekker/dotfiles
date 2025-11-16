-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)



-------------------- Options --------------------

-- Basics
vim.o.relativenumber = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.o.wrap = false

-- Visual
vim.o.winborder = "rounded"
vim.o.colorcolumn = "91"
vim.o.signcolumn = "yes"
vim.o.pumblend = 10
vim.o.winblend = 10

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Timing
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- File handling
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.cache/nvim_undodir")
vim.o.autoread = true
vim.o.autowrite = false

-- Behavior
vim.o.mouse = "a"

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

-- Splitting
vim.o.splitbelow = true
vim.o.splitright = true



-------------------- Mappings --------------------

vim.g.mapleader = " "
local map = vim.keymap.set

-- Escaping
map("i", "jk", "<Esc>")

-- Buffer actions
map("n", "<leader>c", "<cmd>bdelete<CR>")
map("n", "<leader>C", "<cmd>bdelete!<CR>")
map("n", "<leader>n", "<cmd>tabe<CR>")
map("n", "<leader>o", "<cmd>update<CR>:so<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>Q", "<cmd>q!<CR>")
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>W", "<cmd>w!<CR>")
map("n", "H", "<cmd>bprev<CR>")
map("n", "L", "<cmd>bnext<CR>")

-- Package Actions
map("n", "<leader>pi", ":Lazy install<CR>")
map("n", "<leader>ps", ":Lazy<CR>")
map("n", "<leader>pu", ":Lazy update<CR>")



-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                require("tokyonight").setup({ transparent = true })
                vim.cmd("colorscheme tokyonight-night")
            end,
        },
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    }
                }
            },
            config = function(_, opts)
                require("mason").setup(opts)

                map("n", "<leader>pm", ":Mason<CR>")
                map("n", "<leader>pM", ":MasonUpdate<CR>")
            end,
        },
        { "neovim/nvim-lspconfig" },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                }
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            lazy = false,
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    auto_install = true,
                    ensure_installed = { "lua", "python" },
                    highlight = { enable = true },
                    indent = { enable = true },
                    additional_vim_regex_highlighting = false,
                })
            end,
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            opts = {
                keymap = { preset = "default" },

                signature = { enabled = true },

                fuzzy = { implementation = "prefer_rust_with_warning" },
            },
            opts_extend = { "sources.default" },
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
            opts = {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                },
                extensions = {
                    ["ui-select"] = {}
                }
            },
            config = function(_, opts)
                require("telescope").setup(opts)
                pcall(require("telescope").load_extension, "ui-select")

                local tele = require("telescope.builtin")

                local tele_map = function(keys, func, desc)
                    map("n", "<leader>f" .. keys, func, { desc = "Find: " .. desc })
                end

                tele_map("/", tele.current_buffer_fuzzy_find, "within buffer")
                tele_map("b", tele.buffers, "buffers")
                tele_map("c", tele.grep_string, "word under cursor")
                tele_map("C", tele.commands, "commands")
                tele_map("f", tele.find_files, "files")
                tele_map("g", tele.live_grep, "live grep")
                tele_map("h", tele.help_tags, "help")
                tele_map("k", tele.keymaps, "keymaps")
                tele_map("m", tele.man_pages, "man pages")

                tele_map("F", function() tele.find_files({ hidden = true }) end, "all files")
                tele_map("T", function() tele.colorscheme({ enable_preview = true }) end, "colorscheme")
            end
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { { "nvim-lua/plenary.nvim" } },
            config = function()
                local harpoon = require("harpoon")

                harpoon:setup()

                map("n", "<leader>a", function() harpoon:list():add() end)
                map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

                map("n", "<C-h>", function() harpoon:list():select(1) end)
                map("n", "<C-j>", function() harpoon:list():select(2) end)
                map("n", "<C-k>", function() harpoon:list():select(3) end)
                map("n", "<C-l>", function() harpoon:list():select(4) end)
            end,
        },
        {
            "folke/trouble.nvim",
            opts = {},
            cmd = "Trouble",
            keys = {
            },
        },
        {
            "tpope/vim-fugitive",
            config = function()
                map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git: blame" })
                map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git: commit" })
                map("n", "<leader>gs", ":Git<CR>", { desc = "Git: status" })
            end,
        },
        {
            "lewis6991/gitsigns.nvim",
            config = function(_, opts)
                local gs = require("gitsigns")

                gs.setup(opts)

                map("n", "<leader>gp", gs.preview_hunk, { desc = "Git: preview hunk" })
            end,
        },
        {
            "mbbill/undotree",
            config = function()
                map("n", "<leader>u", vim.cmd.UndotreeToggle)
            end,
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "tokyonight" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})



-------------------- LSP & THE LIKE --------------------

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

vim.lsp.config("isort", {
    enabled = true,
    profile = "black",
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
