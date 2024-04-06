return {
  "folke/trouble.nvim",
  config = function()
    local trouble = require("trouble")
    trouble.setup({
      icons = false,
    })

    require("utils").set_mappings({
      mode = "n",

      ["<leader>lD"] = { fn = trouble.toggle, desc = "Toggle trouble" },
      ["[t"] = { fn = function() trouble.next({ skip_groups = true, jump = true }) end,
        desc = "Go to next issue" },
      ["]t"] = { fn = function() trouble.previous({ skip_groups = true, jump = true }) end,
        desc = "Go to next issue" },
    })
  end
}

