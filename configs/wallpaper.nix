{ config, pkgs, ... }:

{
  home.file.".local/bin/wallselect" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      WALLPAPER_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Wallpapers"
      WALLPAPER_LINK="$HOME/.wallpaper"

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

      ln -sf "$(realpath "$SELECTED")" "$WALLPAPER_LINK"

      ${pkgs.awww}/bin/awww img "$WALLPAPER_LINK" || \
        ${pkgs.libnotify}/bin/notify-send "wallselect" "awww failed"

      ${pkgs.matugen}/bin/matugen image "$(realpath "$WALLPAPER_LINK")" -q --source-color-index 0 || \
        ${pkgs.libnotify}/bin/notify-send "wallselect" "matugen failed"
    '';
  };

  home.file.".local/bin/wallpaper-pick" = {
    executable = true;
    text = ''
      #!${pkgs.fish}/bin/fish
${builtins.readFile ./scripts/wallpaper-pick}
    '';
  };
}
