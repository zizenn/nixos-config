{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ opencode ];

  xdg.configFile."opencode/opencode.jsonc" = {
    text = ''
      {
        "$schema": "https://opencode.ai/config.json",
        "model": "opencode/deepseek-v4-flash-free",
        "provider": {
          "ollama": {
            "npm": "@ai-sdk/openai-compatible",
            "name": "Ollama (local)",
            "options": {
              "baseURL": "http://localhost:11434/v1"
            },
            "models": {
              "qwen3-coder:latest": {
                "name": "Qwen3 Coder 30B",
                "limit": { "context": 131072, "output": 32768 }
              },
              "qwen3-coder-64k:latest": {
                "name": "Qwen3 Coder 8B (64k)",
                "limit": { "context": 40960, "output": 16384 }
              },
              "qwen2.5-coder:14b": {
                "name": "Qwen2.5 Coder 14B",
                "limit": { "context": 32768, "output": 16384 }
              },
              "freehuntx/qwen3-coder:8b": {
                "name": "Qwen3 Coder 8B (freehuntx)",
                "limit": { "context": 40960, "output": 16384 }
              },
              "qwen2.5:1.5b": {
                "name": "Qwen2.5 1.5B",
                "limit": { "context": 32768, "output": 8192 }
              },
              "codegemma:7b-instruct": {
                "name": "CodeGemma 7B",
                "limit": { "context": 8192, "output": 4096 }
              }
            }
          }
        }
      }
    '';
    force = true;
  };
}
