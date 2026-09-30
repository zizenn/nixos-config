{ ... }: {
  imports = [
    ./niri.nix
    ./kitty.nix
    ./noctalia.nix
    # Replaced by Noctalia (kept on disk for easy revert):
    # ./mako.nix
    # ./waybar.nix
    # ./rofi.nix
    # ./wleave.nix
    ./wallpaper.nix
    ./portals.nix
  ];
}