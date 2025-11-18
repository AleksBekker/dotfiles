-- init.lua
--
-- My single-file Neovim configuration
--
-- TODO:
--   * Fix Plenary on MacOS
--   * Figure out Mason + lspconfig integration
--   * Consider DAP use instead of tmux + entr workflow
--   - Configure built-in terminal and mappings
--   - Move from Lazy plugin manager to builtin upon 0.12 update
--     - Remove the .gitignore when no longer using lazy.nvim
--   - Consider moving from blink.nvim to builtin nvim completions
--   - Fix Trouble config and set up mappings
--   - Disable lua autoindenting within table tables (seen in weird spacing in package
--     installation)


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
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99

-- Splitting
vim.o.splitbelow = true
vim.o.splitright = true



-------------------- Standard Mappings --------------------

vim.g.mapleader = " "
local map = vim.keymap.set

-- Escaping
map("i", "jk", "<Esc>")

-- Buffer actions
map("n", "<leader>c", "<cmd>bdelete<CR>")
map("n", "<leader>C", "<cmd>bdelete!<CR>")
map("n", "<leader>n", "<cmd>tabnew<CR>")
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

-- Movement
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Other
map("n", "<leader>e", "<cmd>Ex<cr>", { desc = "Explorer: open" })



-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { "folke/tokyonight.nvim",                  lazy = false,       priority = 1000 },
        { "mason-org/mason.nvim" },
        { "neovim/nvim-lspconfig" },
        { "folke/lazydev.nvim",                     ft = "lua" },
        { "nvim-treesitter/nvim-treesitter",        branch = "master",  build = ":TSUpdate" },
        { "nvim-lua/plenary.nvim" },
        { "saghen/blink.cmp",                       version = "1.*" },
        { "nvim-telescope/telescope.nvim",          tag = "0.1.8" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { "ThePrimeagen/harpoon",                   branch = "harpoon2" },
        { "folke/trouble.nvim",                     cmd = "Trouble",    keys = {} },
        { "tpope/vim-fugitive" },
        { "lewis6991/gitsigns.nvim" },
        { "mbbill/undotree" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "tokyonight" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})



-------------------- PLUGIN SETUP --------------------

-- Colors

---@diagnostic disable: missing-fields
require("tokyonight").setup({ transparent = true })
vim.cmd("colorscheme tokyonight-night")


-- Code Assistance

---@diagnostic disable: missing-fields
require("nvim-treesitter.configs").setup({
    auto_install = true,
    ensure_installed = { "lua", "python" },
    highlight = { enable = true },
    indent = { enable = true },
    additional_vim_regex_highlighting = false,
})

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
        }
    }
})


-- Movement

require("telescope").setup({
    defaults = {
        winblend = vim.o.winblend,
        prompt_prefix = " ",
        selection_caret = " ",
    },
    extensions = {
        ["ui-select"] = {}
    },
})
pcall(require("telescope").load_extension, "ui-select")

require("harpoon"):setup()


-- Other

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    }
})

-------------------- PLUGIN MAPPINGS --------------------

-- Mason
map("n", "<leader>pm", ":Mason<CR>")
map("n", "<leader>pM", ":MasonUpdate<CR>")

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
tele_map("F", function() builtin.find_files({ hidden = true }) end, "all files")
tele_map("T", function() builtin.colorscheme({ enable_preview = true }) end, "colorscheme")

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", "<C-h>", function() harpoon:list():select(1) end)
map("n", "<C-j>", function() harpoon:list():select(2) end)
map("n", "<C-k>", function() harpoon:list():select(3) end)
map("n", "<C-l>", function() harpoon:list():select(4) end)

-- Git Fugitive
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git: blame" })
map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git: commit" })
map("n", "<leader>gs", ":Git<CR>", { desc = "Git: status" })

-- Git Signs
local gitsigns = require "gitsigns"
map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git: preview hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Git: previous hunk" })
map("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Git: next hunk" })

-- Undo Tree
map("n", "<leader>u", vim.cmd.UndotreeToggle)

