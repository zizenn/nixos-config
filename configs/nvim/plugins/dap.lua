return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Start / Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Restart Session" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
      { "<leader>dh", function() require("dapui").eval() end, desc = "Evaluate" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.after.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.after.event_exited.dapui_config = function() dapui.close() end

      -- C / C++ (GDB)
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            name = "Launch with make",
            type = "gdb",
            request = "launch",
            program = function()
              local makefile = vim.fn.findfile("Makefile", vim.fn.getcwd() .. ";")
              if makefile ~= "" then
                vim.notify("Building with make...", vim.log.levels.INFO)
                vim.fn.system("make -C " .. vim.fn.fnamemodify(makefile, ":h"))
              end
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
              return vim.split(vim.fn.input("Arguments: ") or "", " ")
            end,
          },
          {
            name = "Launch (no build)",
            type = "gdb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
              return vim.split(vim.fn.input("Arguments: ") or "", " ")
            end,
          },
        }
      end

      -- Python (debugpy — needs python3Packages.debugpy in nix or pip install debugpy)
      require("dap-python").setup("python3")

      -- Lua (local)
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = "127.0.0.1", port = config.port or 8086 })
        local port = config.port or 8086
        if config.source_filetypes then
          require("os").execute(string.format(
            "lua -e \"package.path=package.path..';%s/?.lua'\" -e \"dofile('%s/scripts/debugger.lua')({port=%d})\" &",
            vim.fn.stdpath("data"), vim.fn.stdpath("data"), port
          ))
        end
      end

      dap.configurations.lua = {
        {
          name = "Current File",
          type = "nlua",
          request = "launch",
          program = { file = vim.fn.expand("%:p") },
        },
      }

      -- JavaScript / TypeScript (Node.js)
      -- Requires js-debug-adapter: nixpkgs.vscode-js-debug or npm i -g js-debug-adapter
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      for _, lang in ipairs({ "javascript", "typescript" }) do
        dap.configurations[lang] = {
          {
            name = "Launch via Node",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
          },
          {
            name = "Attach to Process",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- Shell / Bash
      dap.adapters.bash = {
        type = "executable",
        command = "bash-debug-adapter",
        args = { "0.0.0.0", "0" },
      }

      dap.configurations.sh = {
        {
          name = "Launch",
          type = "bash",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          args = function()
            local args_str = vim.fn.input("Arguments: ")
            return vim.split(args_str, " ")
          end,
        },
      }
      dap.configurations.zsh = dap.configurations.sh
      dap.configurations.bash = dap.configurations.sh

      -- HTML — launch a local server and attach Chrome
      dap.configurations.html = {
        {
          name = "Launch Chrome",
          type = "pwa-chrome",
          request = "launch",
          url = function()
            return vim.fn.input("URL: ", "http://localhost:8080")
          end,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
      dap.configurations.css = dap.configurations.html

      -- Sign decorations
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
