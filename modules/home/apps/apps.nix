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
    glaxnimate
    kdePackages.kdenlive
    mediainfo
    obsidian
    ollama
    pandoc
    pavucontrol
    proton-pass
    protonmail-desktop
    steam
    vesktop
    vlc
    zathura

    inputs.zen-browser.packages.${system}.default
  ];
}
