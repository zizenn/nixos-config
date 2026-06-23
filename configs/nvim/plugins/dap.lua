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
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Re-run last" },
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

      -- Util: prompt for args string
      local function prompt_args()
        local raw = vim.fn.input("Program arguments: ")
        if raw == "" then return {} end
        return vim.split(raw, " ")
      end

      -- Util: detect build system in cwd (walks up)
      local function detect_build(dir)
        if not dir then dir = vim.fn.getcwd() end
        for _, entry in ipairs({
          { file = "Makefile",      type = "make" },
          { file = "CMakeLists.txt", type = "cmake" },
          { file = "meson.build",   type = "meson" },
        }) do
          local found = vim.fn.findfile(entry.file, dir .. ";")
          if found ~= "" then
            return entry.type, vim.fn.fnamemodify(found, ":h")
          end
        end
        -- Fallback: check for compile_commands.json
        local cc = vim.fn.findfile("compile_commands.json", dir .. ";")
        if cc ~= "" then
          if vim.fn.filereadable(vim.fn.fnamemodify(cc, ":h") .. "/CMakeCache.txt") == 1 then
            return "cmake", vim.fn.fnamemodify(cc, ":h")
          end
          return "make", vim.fn.fnamemodify(cc, ":h")
        end
        return nil, nil
      end

      -- Util: try to find the built binary
      local function probe_executable(build_dir)
        if not build_dir or build_dir == "" then
          build_dir = vim.fn.getcwd()
        end
        local project = vim.fn.fnamemodify(build_dir, ":t")
        local patterns = {
          build_dir .. "/" .. project,
          build_dir .. "/build/" .. project,
          build_dir .. "/build/debug/" .. project,
          build_dir .. "/build/Debug/" .. project,
          build_dir .. "/target/" .. project,
          build_dir .. "/a.out",
          build_dir .. "/build/a.out",
        }
        for _, p in ipairs(patterns) do
          if vim.fn.executable(p) == 1 then return p end
        end
        return nil
      end

      -- Util: build and return executable path (or nil on fail)
      local function build_project(build_type, build_dir)
        if build_type == "make" then
          vim.notify("Building with make…", vim.log.levels.INFO)
          local out = vim.fn.system("make -C " .. vim.fn.escape(build_dir, " ") .. " 2>&1")
          if vim.v.shell_error ~= 0 then
            vim.notify("Build failed:\n" .. out, vim.log.levels.ERROR)
            return nil
          end
          return probe_executable(build_dir)
        end
        if build_type == "cmake" then
          vim.notify("Building with cmake --build…", vim.log.levels.INFO)
          local out = vim.fn.system("cmake --build " .. vim.fn.escape(build_dir, " ") .. " 2>&1")
          if vim.v.shell_error ~= 0 then
            vim.notify("Build failed:\n" .. out, vim.log.levels.ERROR)
            return nil
          end
          return probe_executable(build_dir)
        end
        if build_type == "meson" then
          vim.notify("Building with ninja…", vim.log.levels.INFO)
          local out = vim.fn.system("ninja -C " .. vim.fn.escape(build_dir, " ") .. "/build 2>&1")
          if vim.v.shell_error ~= 0 then
            vim.notify("Build failed:\n" .. out, vim.log.levels.ERROR)
            return nil
          end
          return probe_executable(build_dir)
        end
        return nil
      end

      -- Util: build & launch config factory
      local function make_c_configs(adapter, label)
        local configs = {}
        -- 1) Full build + launch
        table.insert(configs, {
          name = label .. " (build + launch)",
          type = adapter,
          request = "launch",
          program = function()
            local bt, bd = detect_build()
            if bt then
              local exe = build_project(bt, bd)
              if exe then return exe end
            end
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = prompt_args,
        })
        -- 2) Launch existing binary (no build)
        table.insert(configs, {
          name = label .. " (launch existing)",
          type = adapter,
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = prompt_args,
        })
        -- 3) Attach to running process
        table.insert(configs, {
          name = label .. " (attach)",
          type = adapter,
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        })
        return configs
      end

      -- C / C++ (GDB — primary)
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-q", "--interpreter=dap" },
      }

      -- C / C++ (LLDB — alternative)
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        args = {},
      }

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {}
        for _, cfg in ipairs(make_c_configs("gdb", "gdb")) do
          table.insert(dap.configurations[lang], cfg)
        end
        for _, cfg in ipairs(make_c_configs("lldb", "lldb")) do
          table.insert(dap.configurations[lang], cfg)
        end
      end

      -- Python (debugpy)
      require("dap-python").setup("python3")

      -- Lua (local)
      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = "127.0.0.1", port = config.port or 8086 })
        local port = config.port or 8086
        if config.source_filetypes then
          vim.fn.system(string.format(
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

      -- Shell / Bash (needs `bash-debug-adapter` in PATH)
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
            local raw = vim.fn.input("Arguments: ")
            if raw == "" then return {} end
            return vim.split(raw, " ")
          end,
        },
      }
      dap.configurations.zsh = dap.configurations.sh
      dap.configurations.bash = dap.configurations.sh

      -- HTML / CSS — connect to local dev server
      dap.configurations.html = {
        {
          name = "Launch Chrome",
          type = "pwa-chrome",
          request = "launch",
          url = function()
            return vim.fn.input("URL: ", "http://localhost:5173")
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
