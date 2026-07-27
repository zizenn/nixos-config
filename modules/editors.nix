{lib, ...}: {
  homeManager.modules.base = {pkgs, config, ...}: let
    neovimRuntimePackages = with pkgs; [
      lua-language-server typescript-language-server vscode-langservers-extracted
      pyright clang-tools tree-sitter stylua prettier
      python3Packages.autopep8 python3Packages.debugpy nixd nixfmt
      gnumake gcc
    ];
    neovimRuntimeEnv = pkgs.buildEnv {
      name = "neovim-runtime-env";
      paths = neovimRuntimePackages;
    };
    nvim = pkgs.writeShellScriptBin "nvim" ''
      export PATH="${neovimRuntimeEnv}/bin''${PATH:+:$PATH}"
      exec ${pkgs.neovim}/bin/nvim "$@"
    '';
  in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    programs.zed-editor = {
      enable = true;
      installRemoteServer = true;
    };
    home.packages = with pkgs; [
      nvim opencode gemini-cli
    ];
    xdg.configFile = {
      "nvim".source = ./neovim/nvim;
      "nvim".recursive = true;
      "opencode/opencode.jsonc".text = ''
        {
          "$schema": "https://opencode.ai/config.json",
          "model": "opencode/deepseek-v4-flash-free",
          "provider": {
            "ollama": {
              "npm": "@ai-sdk/openai-compatible",
              "name": "Ollama (local)",
              "options": {"baseURL": "http://localhost:11434/v1"},
              "models": {
                "qwen3-coder:latest": {
                  "name": "Qwen3 Coder 30B",
                  "limit": {"context": 131072, "output": 32768}
                },
                "qwen3-coder-64k:latest": {
                  "name": "Qwen3 Coder 8B (64k)",
                  "limit": {"context": 40960, "output": 16384}
                },
                "qwen2.5-coder:14b": {
                  "name": "Qwen2.5 Coder 14B",
                  "limit": {"context": 32768, "output": 16384}
                },
                "freehuntx/qwen3-coder:8b": {
                  "name": "Qwen3 Coder 8B (freehuntx)",
                  "limit": {"context": 40960, "output": 16384}
                },
                "qwen2.5:1.5b": {
                  "name": "Qwen2.5 1.5B",
                  "limit": {"context": 32768, "output": 8192}
                },
                "codegemma:7b-instruct": {
                  "name": "CodeGemma 7B",
                  "limit": {"context": 8192, "output": 4096}
                }
              }
            }
          }
        }
      '';
      "opencode/opencode.jsonc".force = true;
      "zed/themes/.keep".text = "";
      "zed/tasks.json".source = ./zed/tasks.json;
    };
    home.file.".clang-format".text = ''
      BasedOnStyle: Google
      IndentWidth: 6
      ContinuationIndentWidth: 6
      AccessModifierOffset: -6
    '';
  };
}
