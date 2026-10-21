{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    # merged with module defaults (zlib, zstd, openssl, curl, systemd, stdenv.cc.cc, ...)
    libraries = with pkgs; [
      glib
      expat
      dbus
      nss
      nspr
      libxkbcommon
      wayland
      libdrm
    ];
  };
}
