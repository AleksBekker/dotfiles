-- init.lua
--
-- My single-file Neovim configuration
--
-- TODO:
--   * Consider DAP use instead of tmux + entr workflow
--   - Configure built-in terminal and mappings
--   - Consider moving from blink.nvim to builtin nvim completions
--   - Disable lua autoindenting within table tables (seen in weird spacing in package
--     installation)
--   - Optional: add colorizer back when they figure out their deprecations

-------------------- Options --------------------

-- Basics
vim.o.relativenumber = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.confirm = true
vim.o.showmode = false

-- Visual
vim.o.winborder = "rounded"
vim.o.colorcolumn = "91"
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.pumblend = 5
vim.o.winblend = 5

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
vim.o.hlsearch = false
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
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99

-- White space characters
vim.o.listchars = "space:·,tab:→ ,eol:↵"

-- Splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Spell Check
vim.o.spell = true
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "green" })
    end,
})

-- Colors
vim.cmd("colorscheme retrobox")

-------------------- Standard Mappings --------------------

vim.g.mapleader = " "
local map = vim.keymap.set

-- Escaping
map("i", "jk", "<Esc>")

-- Buffer actions
map("n", "<leader>n", "<cmd>tabnew<cr>")
map("n", "<leader>o", "<cmd>update<bar>restart <cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>Q", "<cmd>q!<cr>")
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>W", "<cmd>w!<cr>")
map("n", "<leader>x", "<cmd>bdelete<cr>")
map("n", "<leader>X", "<cmd>bdelete!<cr>")
map("n", "H", "<cmd>bprev<cr>")
map("n", "L", "<cmd>bnext<cr>")

-- Movement
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Quickfix List
map("n", "<leader>cx", "<cmd>cclose<CR>", { desc = "Quickfix: close" })
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Quickfix: open" })

-- UI

--- @param name string
local option_toggler = function(name)
    return function()
        vim.opt[name] = not vim.opt[name]:get()
        print("Set " .. name .. " to " .. tostring(vim.opt[name]:get()))
    end
end

vim.keymap.set("n", "<leader>iw", option_toggler("wrap"), { desc = "UI: Toggle wrap" })
vim.keymap.set("n", "<leader>ii", option_toggler("list"), { desc = "UI: Toggle whitespace indicators" })
vim.keymap.set("n", "<leader>is", option_toggler("spell"), { desc = "UI: Toggle spell" })

-------------------- Plugins --------------------

local function gh(x)
    return "https://github.com/" .. x
end

vim.pack.add({

    -- UI
    gh("nvim-lua/plenary.nvim"),
    gh("stevearc/dressing.nvim"),

    -- Code Assistance
    gh("mason-org/mason.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("nvimtools/none-ls.nvim"),
    gh("jay-babu/mason-null-ls.nvim"),
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },

    -- DAP
    gh("mfussenegger/nvim-dap"),
    gh("rcarriga/nvim-dap-ui"),
    gh("nvim-neotest/nvim-nio"),
    gh("leoluz/nvim-dap-go"),

    -- Language-Specific Plugins
    gh("windwp/nvim-ts-autotag"),
    gh("b0o/schemastore.nvim"),
    gh("folke/lazydev.nvim"),

    -- Movement
    { src = gh("nvim-telescope/telescope.nvim"), version = vim.version.range("0.1.8") },
    gh("nvim-telescope/telescope-ui-select.nvim"),
    { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },

    -- Other
    gh("tpope/vim-fugitive"),
    gh("lewis6991/gitsigns.nvim"),
    gh("mbbill/undotree"),
    -- gh("norcalli/nvim-colorizer.lua"),
    { src = gh("nvim-mini/mini.nvim"), version = "stable" },
    gh("folke/todo-comments.nvim"),
})

-------------------- PLUGIN SETUP --------------------

-- UI

require("dressing").setup()
require("mini.icons").setup()
require("mini.statusline").setup()

-- Code Assistance

---@diagnostic disable: missing-fields
-- require("nvim-treesitter.configs").setup({
--     auto_install = true,
--     ensure_installed = { "lua", "python" },
--     highlight = { enable = true },
--     indent = { enable = true },
--     additional_vim_regex_highlighting = false,
-- })

require("blink.cmp").setup({
    keymap = { preset = "default" },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup()

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
    },
})

require("mason-null-ls").setup({
    handlers = {},
})

require("mini.files").setup()

-- Movement

require("telescope").setup({
    defaults = {
        winblend = vim.o.winblend,
        prompt_prefix = " ",
        selection_caret = " ",
    },
    extensions = {
        ["ui-select"] = {},
    },
})
pcall(require("telescope").load_extension, "ui-select")

require("harpoon"):setup()

-- Language-specific Plugins
require("nvim-ts-autotag").setup()

-- Other

-- require("colorizer").setup({ "css", "typescript", "javascript" })

require("gitsigns").setup({
    current_line_blame = true,
})

require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.cmdline").setup()
require("mini.surround").setup()
require("todo-comments").setup()

-------------------- PLUGIN MAPPINGS --------------------

-- Mason
map("n", "<leader>pm", "<cmd>Mason<CR>")
map("n", "<leader>pM", "<cmd>MasonUpdate<CR>")

-- Telescope
local tele_map = function(keys, func, desc)
    map("n", "<leader>f" .. keys, func, { desc = "Find: " .. desc })
end

local builtin = require("telescope.builtin")
tele_map("/", builtin.current_buffer_fuzzy_find, "within buffer")
tele_map("b", builtin.buffers, "buffers")
tele_map("c", builtin.grep_string, "word under cursor")
tele_map("C", builtin.commands, "commands")
tele_map("f", builtin.find_files, "files")
tele_map("g", builtin.live_grep, "live grep")
tele_map("h", builtin.help_tags, "help")
tele_map("k", builtin.keymaps, "keymaps")
tele_map("m", builtin.man_pages, "man pages")
tele_map("F", function()
    builtin.find_files({ hidden = true })
end, "all files")
tele_map("T", function()
    builtin.colorscheme({ enable_preview = true })
end, "colorscheme")

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>a", function()
    harpoon:list():add()
end)
map("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
map("n", "<C-h>", function()
    harpoon:list():select(1)
end)
map("n", "<C-j>", function()
    harpoon:list():select(2)
end)
map("n", "<C-k>", function()
    harpoon:list():select(3)
end)
map("n", "<C-l>", function()
    harpoon:list():select(4)
end)

-- Git Fugitive
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git: blame" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git: commit" })
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git: status" })

-- Git Signs
local gitsigns = require("gitsigns")
map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git: preview hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Git: previous hunk" })
map("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Git: next hunk" })

-- Undo Tree
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- File Explorer
map("n", "<leader>e", MiniFiles.open, { desc = "Explorer: open" })

-- Todos

local todos = require("todo-comments")
map("n", "]t", todos.jump_next, { desc = "Todos: next" })
map("n", "[t", todos.jump_prev, { desc = "Todos: prev" })
map("n", "<leader>lt", "<cmd>TodoQuickFix<CR>", { desc = "Todos: list" })
