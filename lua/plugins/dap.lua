--[[
DAP: Debugger Adapter Protocal

--]]
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function ()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end



        local map = vim.keymap.set
        map('n', '<leader>dt', dap.toggle_breakpoint, { desc = "Toggle Breakpoint"}) -- pin/unpin a breakpoint
        map('n', '<leader>dc', dap.continue, { desc = "Continue"})


    end

}
