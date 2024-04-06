return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.mypy.with({
          extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
            return { "--python-executable", virtual .. "/bin/python3" }
          end
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,

        -- Go
        null_ls.builtins.formatting.gofmt,

        -- Rust
        null_ls.builtins.formatting.rustfmt,
      }
    })
  end,
}
