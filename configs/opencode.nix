{ config, pkgs, ... }:

{
  xdg.configFile."opencode/opencode.jsonc" = {
    text = ''
      {
        "$schema": "https://opencode.ai/config.json",
        "provider": {
          "ollama": {
            "npm": "@ai-sdk/openai-compatible",
            "name": "Ollama",
            "options": {
              "baseURL": "http://localhost:11434/v1"
            }
          }
        }
      }
    '';
    force = true;
  };
}
