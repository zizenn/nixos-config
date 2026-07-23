{ config, pkgs, lib, ... }:

let
  shardLibPath = lib.makeLibraryPath (with pkgs; [
    libGL
    libx11
    libxcb
    libpulseaudio
    webkitgtk_4_1
    gtk3
    gdk-pixbuf
    librsvg
    glib-networking
    gsettings-desktop-schemas
    libsoup_3
    openssl
  ]);
  shardBin = "${config.home.homeDirectory}/.local/bin/shard";
in
{
  home.packages = [ pkgs.appimage-run ];

  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.file.".local/bin/shard" = {
    executable = true;
    text = ''
      #!${pkgs.fish}/bin/fish

      set -gx SHARD_DIR "$HOME/.local/share/shard"
      set -gx SHARD_APPIMAGE "$SHARD_DIR/shard.AppImage"

      if not test -f "$SHARD_APPIMAGE"
          mkdir -p "$SHARD_DIR"
          echo "Downloading latest Shard AppImage..."
          curl -L \
            -o "$SHARD_APPIMAGE" \
            "https://github.com/Th0rgal/shard/releases/latest/download/shard-launcher-linux-x64.AppImage" \
            || begin
              rm -f "$SHARD_APPIMAGE"
              echo "Download failed"
              exit 1
            end
          chmod +x "$SHARD_APPIMAGE"
      end

      set -gx AMD_VULKAN_ICD RADV
      set -gx mesa_glthread true
      set -gx vblank_mode 0
      set -gx LD_LIBRARY_PATH "${shardLibPath}:$LD_LIBRARY_PATH"
      set -gx SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      set -gx NIX_SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

      exec ${pkgs.appimage-run}/bin/appimage-run "$SHARD_APPIMAGE" $argv
    '';
  };

  xdg.desktopEntries.shard = {
    name = "Shard";
    exec = "${shardBin} %U";
    terminal = false;
    categories = [ "Game" ];
    comment = "Experimental Minecraft launcher";
    mimeType = [ "x-scheme-handler/minecraft" ];
  };
}
