{ config, pkgs, ... }:

{
  imports = [
    ./configs/zsh.nix
    ./configs/kitty.nix
    ./configs/hyprland.nix
    ./configs/matugen.nix
    ./configs/wallpaper.nix
    ./configs/neovim.nix
    ./configs/quickshell.nix
    ./configs/zed.nix
    ./configs/yazi.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home.username = "zizenn";
  home.homeDirectory = "/home/zizenn";

  # ENVIRONMENT VARIABLES
  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
    ANTHROPIC_BASE_URL = "http://localhost:11434";
    ANTHROPIC_AUTH_TOKEN = "ollama";
    ANTHROPIC_API_KEY = "ollama";
  };

  programs.zsh.enable = true;

  # CONFIGURATION
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sakif";
        email = "zizenn@proton.me";
      };
      core = {
        editor = "nvim";
      };
    };
  };

  # SYSTEM
  home.stateVersion = "26.05";
}
