{ config, pkgs, ... }:

{
  home.file.".local/bin/wallselect" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      WALLPAPER_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}"
      WALLPAPER_LINK="$HOME/.wallpaper"
      KITTY_COLORS="$HOME/.config/kitty/current-colors.conf"

      mkdir -p "$WALLPAPER_DIR"

      # pick image with yazi
      TMP_FILE="$(mktemp -t "wallselect.XXXXXX")"
      ${pkgs.kitty}/bin/kitty --class yazi-float -e ${pkgs.yazi}/bin/yazi "$WALLPAPER_DIR" --chooser-file="$TMP_FILE"

      SELECTED="$(cat "$TMP_FILE")"
      rm -f "$TMP_FILE"

      [ -z "$SELECTED" ] && exit 0

      MIME=$(${pkgs.file}/bin/file --mime-type -b "$SELECTED")
      case "$MIME" in
        image/*) ;;
        *) ${pkgs.libnotify}/bin/notify-send "wallselect" "not an image"; exit 1 ;;
      esac

      # symlink wallpaper for persistence
      ln -sf "$(realpath "$SELECTED")" "$WALLPAPER_LINK"

      # set wallpaper
      ${pkgs.awww}/bin/awww img "$WALLPAPER_LINK" || \
        ${pkgs.libnotify}/bin/notify-send "wallselect" "awww failed"

      # run matugen -> renders kitty + nvim templates automatically
      # resolve symlink since matugen 4.x can't determine image format from symlinks
      ${pkgs.matugen}/bin/matugen image "$(realpath "$WALLPAPER_LINK")" -q --source-color-index 0 || \
        ${pkgs.libnotify}/bin/notify-send "wallselect" "matugen failed"

      # apply colors to running kitty instances
      ${pkgs.kitty}/bin/kitty @ set-colors "$KITTY_COLORS" 2>/dev/null || true
    '';
  };
}
