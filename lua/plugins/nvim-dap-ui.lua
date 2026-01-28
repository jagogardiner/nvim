return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "wojciech-kulik/xcodebuild.nvim" },
  config = function()
    -- Setup xcodebuild DAP integration
    local xcodebuild = require("xcodebuild.integrations.dap")
    xcodebuild.setup()

    -- Xcodebuild-specific keymaps
    vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
    vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
    vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })

    -- Set keymaps for nvim-dap actions
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, { desc = "Start/Continue Debugging" })
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end, { desc = "Step Over" })
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end, { desc = "Step Into" })
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end, { desc = "Step Out" })
    vim.keymap.set("n", "<M-b>", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })

    -- Setup nvim-dap-ui
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup() -- Initialize nvim-dap-ui

    -- Automatically open Dap UI when debugging starts
    dap.listeners.before.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Command and key-map for evaluating expressions
    vim.api.nvim_create_user_command("DapCloseUI", function()
      dapui.close()
    end, { desc = "Close Dap UI windows" })

    vim.keymap.set({ "n", "v" }, "<M-e>", function()
      require("dapui").eval()
    end, { desc = "Evaluate Expression" })
  end,
}
