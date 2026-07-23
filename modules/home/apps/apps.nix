{
  pkgs,
  inputs,
  ...
}:

let
  inherit (pkgs.stdenv.hostPlatform) system;
  lib = pkgs.lib;

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
    modrinth-app-fixed
  ];
}
