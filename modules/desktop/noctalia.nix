{lib, ...}: {
  # Noctalia v5 (nixpkgs `noctalia`, NOT legacy quickshell `noctalia-shell`)
  # replaces waybar + mako + rofi + wleave.
  # Settings live in ~/.config/noctalia/ and are managed via the
  # Noctalia Settings GUI (or `programs.noctalia.settings` if we later
  # pin the upstream flake for its home-manager module).
  nixos.modules.base = {
    # Required for Noctalia's wifi / bluetooth / power-profile / battery features
    # (networkmanager, bluetooth and upower are already enabled elsewhere).
    services.power-profiles-daemon.enable = true;
  };

  homeManager.modules.base = {pkgs, ...}: {
    home.packages = with pkgs; [noctalia];
  };
}
