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
      CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/rofi-wallpapers"

      mkdir -p "$CACHE_DIR"

      # build rofi entries with thumbnail icons
      ENTRIES=""
      for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,bmp,webp}; do
        [ -f "$img" ] || continue
        name=$(basename "$img")
        thumb="$CACHE_DIR/$(basename "$img" | sed 's/\.[^.]*$//').png"
        [ -f "$thumb" ] || ${pkgs.imagemagick}/bin/magick "$img" -resize 170x170^ -gravity center -extent 170x170 "$thumb" 2>/dev/null
        ENTRIES+="$name\0icon\x1f$thumb\n"
      done

      SELECTED=$(echo -e "$ENTRIES" | ${pkgs.rofi}/bin/rofi -dmenu -theme wallpaper-grid -p "Wallpaper")
      [ -z "$SELECTED" ] && exit 0

      SELECTED_PATH="$WALLPAPER_DIR/$SELECTED"

      # update symlink
      ln -sf "$(realpath "$SELECTED_PATH")" "$WALLPAPER_LINK"

      # set wallpaper
      ${pkgs.awww}/bin/awww img "$WALLPAPER_LINK" || \
        ${pkgs.libnotify}/bin/notify-send "wallpaper" "awww failed"

      # run matugen (post hook hot-reloads kitty, mako, waybar)
      ${pkgs.matugen}/bin/matugen image "$(realpath "$WALLPAPER_LINK")" -q --source-color-index 0 || \
        ${pkgs.libnotify}/bin/notify-send "wallpaper" "matugen failed"

      ${pkgs.libnotify}/bin/notify-send -i "$SELECTED_PATH" "wallpaper" "Set to $SELECTED"
    '';
  };
}
