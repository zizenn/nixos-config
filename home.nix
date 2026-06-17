{ config, pkgs, ... }:

{
  imports = [
    ./configs/zsh.nix
    ./configs/kitty.nix
    ./configs/hyprland.nix
    ./configs/matugen.nix
    ./configs/wallpaper.nix
    ./configs/neovim.nix
  ];

  home.username = "zizenn";
  home.homeDirectory = "/home/zizenn";


  # ENVIRONMENT VARIABLES
  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # PACKAGES
  home.packages = with pkgs; [
    git
    neovim
    zsh
    yazi
    awww
    fzf
    waybar
    matugen
    opencode
    mako
    ripgrep
    python3
    ntfs3g
    gcc  
    tree-sitter
    zsh-autosuggestions
    zsh-syntax-highlighting
    eza
    fastfetch
  ];

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

