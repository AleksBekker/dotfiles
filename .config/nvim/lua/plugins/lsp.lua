-- Heavily copied from ThePrimeagen and TJ DeVries
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Main LSP Managers
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Completions
    "hrsh7th/nvim-cmp",

    -- Completion Sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "github/copilot.vim",

    -- Other
    "j-hui/fidget.nvim",
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({
      notification = {
        window = {
          winblend = 0,
        },
      },
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        -- "rust_analyzer",
        "pyright",
        "tsserver",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
        end,

        ["rust_analyzer"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
              ["rust_analyzer"] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  runBuildScripts = true,
                },
                checkOnSave = {
                  allFeatures = true,
                  command = "clippy",
                  extraArgs = {
                    "--",
                    "--no-deps",
                    "-Dclippy::correctness",
                    "-Dclippy::complexity",
                    "-Wclippy::perf",
                    "-Wclippy::pedantic",
                  },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
              },
            },
          })
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "copilot" },
      }, {
        { name = "path" },
        { name = "buffer", keyword_length = 5, max_item_count = 5 },
      }),

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true,
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
          },
        }),
      },

      experimental = {
        ghost_text = true,
      },
    })
  end,
}
