{
  pkgs,
  inputs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
in

{
  home.packages = with pkgs; [
    git
    nodejs_26
    zsh
    yazi
    fzf
    matugen
    opencode
    mako
    hyprlock
    hypridle
    ripgrep
    python3
    python3Packages.debugpy
    ntfs3g
    gcc
    clang-tools
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
    pv
    awww
    socat
    ollama
    unzip
    claude-code
    bc
    fd
    vesktop
    inputs.zen-browser.packages.${system}.default
    (pkgs.callPackage ./packages/zennotes/package-desktop.nix { })
    steam
    protonmail-desktop
    zed-editor
    btop
    bat
    lldb
    devenv
    zip
    lazygit
    rofi
    uv
    python3Packages.autopep8
    gdb
    cmake
    catimg
    chafa
    gh
    herdr
    obsidian
    cava
    wttrbar
    bluetui
    wiremix
    inputs.wlctl.packages.${system}.default
    wleave
    wl-clipboard
    libnotify
    glow
    rose-pine-hyprcursor
    rose-pine-cursor
    feh
    vlc
    kdePackages.kdenlive # the vid editor
    glaxnimate # Optional: For text/vector animations
    mediainfo # Optional: For reading video file metadata
    gemini-cli
    proton-pass
    zathura
    lynx
    cmatrix
    cargo
    broot

    # gtk / qt theming
    papirus-icon-theme
    kdePackages.qt6ct
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    tldr
  ];
}
