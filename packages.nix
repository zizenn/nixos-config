{
  pkgs,
  inputs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
  lib = pkgs.lib;

  # The upstream modrinth-app uses symlinkJoin which excludes postBuild from
  # derivation attrs, so overrideAttrs can't fix the wrapping. Instead we
  # recreate the symlinkJoin with output=$out set before wrapGAppsHook runs.
  modrinth-jdks = with pkgs; [ jdk8 jdk17 jdk21 jdk25 ];
  modrinth-app-fixed = pkgs.symlinkJoin {
    name = "modrinth-app-${pkgs.modrinth-app-unwrapped.version}";
    paths = [ pkgs.modrinth-app-unwrapped ];
    nativeBuildInputs = [ pkgs.glib pkgs.wrapGAppsHook3 ];
    buildInputs = [ pkgs.glib-networking pkgs.gsettings-desktop-schemas ];
    runtimeDependencies = lib.makeLibraryPath [
      pkgs.addDriverRunpath.driverLink
      pkgs.libGL pkgs.libx11 pkgs.libxcursor pkgs.libxext pkgs.libxrandr pkgs.libxxf86vm
      (lib.getLib pkgs.stdenv.cc.cc)
      pkgs.flite pkgs.alsa-lib pkgs.libjack2 pkgs.libpulseaudio pkgs.pipewire pkgs.udev
    ];
    postBuild = ''
      output=$out

      gappsWrapperArgs+=(
        --prefix PATH : ${lib.makeSearchPath "bin/java" modrinth-jdks}
        --prefix PATH : ${lib.makeBinPath [ pkgs.xrandr ]}
        --set LD_LIBRARY_PATH $runtimeDependencies
      )

      glibPostInstallHook
      gappsWrapperArgsHook
      wrapGAppsHook
    '';
    meta = {
      inherit (pkgs.modrinth-app-unwrapped.meta)
        description longDescription homepage license maintainers mainProgram platforms broken;
    };
  };
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
    steam
    protonmail-desktop
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
    modrinth-app-fixed
    proton-pass
    zathura
    lynx
    pandoc
    cmatrix
    cargo
    broot

    # LSP servers (mason replacement)
    lua-language-server
    typescript-language-server
    vscode-langservers-extracted
    pyright

    # Formatters (mason replacement)
    stylua
    prettier

    # gtk / qt theming
    papirus-icon-theme
    kdePackages.qt6ct
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    tldr
    cppman
    ncdu
  ];
}
