{ config, pkgs, ... }:

{
  home.file.".local/bin/wallselect" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      WALLPAPER_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Wallpapers"
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

    '';
  };

  home.file.".local/bin/wallpaper-pick" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      WALLPAPER_DIR="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Wallpapers"
      WALLPAPER_LINK="$HOME/.wallpaper"

      mkdir -p "$WALLPAPER_DIR"
      cd "$WALLPAPER_DIR"

      export WALLPAPER_DIR

      SELECTED=$(find . -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -printf '%f\n' | sort \
        | ${pkgs.fzf}/bin/fzf --reverse \
            --preview='${pkgs.kitty}/bin/kitty +kitten icat --clear --transfer-mode=memory --place=$((FZF_PREVIEW_COLUMNS-2))x$((FZF_PREVIEW_LINES-2))@0x0 "$WALLPAPER_DIR"/{} 2>/dev/null' \
            --preview-window='right:60%' \
            --header='Select wallpaper (ESC to cancel)' \
            --height=100%)

      [ -z "$SELECTED" ] && exit 0

      SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"

      ln -sf "$(realpath "$SELECTED_PATH")" "$WALLPAPER_LINK"
      ${pkgs.awww}/bin/awww img "$WALLPAPER_LINK" || \
        ${pkgs.libnotify}/bin/notify-send "wallpaper" "awww failed"
      ${pkgs.matugen}/bin/matugen image "$(realpath "$WALLPAPER_LINK")" -q --source-color-index 0 || \
        ${pkgs.libnotify}/bin/notify-send "wallpaper" "matugen failed"
      ${pkgs.libnotify}/bin/notify-send -i "$SELECTED_PATH" "wallpaper" "Set to $SELECTED"
    '';
  };
}
