local dap = require("dap")
local ui = require("dapui")

ui.setup()
require("dap-go").setup()

local map = vim.keymap.set

local set_conditional = function()
    ---@param condition string
    vim.ui.input("Condition:", function(condition)
        dap.toggle_breakpoint(condition)
    end)
end

map("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
map("n", "<leader>dc", set_conditional, { desc = "DAP: set conditional breakpoint" })
map("n", "<leader>dx", dap.run_to_cursor, { desc = "DAP: run to cursor" })

map("n", "<leader>de", function()
    ---@diagnostic disable-next-line: missing-fields
    ui.eval(nil, { enter = true })
end, { desc = "DAP: evaluate" })

map("n", "<F1>", dap.continue, { desc = "DAP: continue" })
map("n", "<F2>", dap.step_into, { desc = "DAP: step into" })
map("n", "<F3>", dap.step_over, { desc = "DAP: step over" })
map("n", "<F4>", dap.step_out, { desc = "DAP: step out" })
map("n", "<F5>", dap.step_back, { desc = "DAP: step back" })
map("n", "<leader>dr", dap.restart, { desc = "DAP: restart" })
map("n", "<leader>du", ui.toggle, { desc = "DAP: toggle UI" })
map("n", "<leader>dq", dap.stop, { desc = "DAP: stop debugger" })

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
