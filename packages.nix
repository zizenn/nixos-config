{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    git
    neovim
    zsh
    yazi
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
    gnumake
    nix-search-cli
    jq
    zoxide
    pavucontrol
    quickshell
    pv
    awww
    socat
    ollama
  unzip
  claude-code
  direnv
  bc
  fd
  vesktop
  inputs.zen-browser.packages.x86_64-linux.default
  pywalfox-native
  steam
  protonmail-desktop
];

}
