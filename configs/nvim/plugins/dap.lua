return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Start Session / Continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over (Next Line)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into Function" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out of Function" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate Debugger" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Manual Toggle DAP UI Layout" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
      }

      dap.configurations.c = {
        {
          name = "Launch Native Engine Binary",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to target executable binary: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}", -- Look how clean this is now!
          stopOnEntry = false,
        },
      }

      local signs = {
        DapBreakpoint = { text = "󰏃", texthl = "DiagnosticSignError", linehl = "", numhl = "" },
        DapBreakpointCondition = { text = "󰟶", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" },
        DapBreakpointRejected = { text = "󰏕", texthl = "DiagnosticSignHint", linehl = "", numhl = "" },
        DapLogPoint = { text = "󰛕", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" },
        DapStopped = { text = "󰁕", texthl = "DiagnosticSignOk", linehl = "Visual", numhl = "DiagnosticSignOk" },
      }

      for name, sign in pairs(signs) do
        vim.fn.sign_define(name, sign)
      end
    end,
  },
}
