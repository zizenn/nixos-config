{ ... }:
{
  # Noctalia v5 (nixpkgs `noctalia`, NOT legacy quickshell `noctalia-shell`)
  # replaces waybar + mako + rofi + wleave.
  # Settings live in ~/.config/noctalia/ and are managed via the
  # Noctalia Settings GUI (or `programs.noctalia.settings` if we later
  # pin the upstream flake for its home-manager module).

  # Required for Noctalia's wifi / power-profile / battery features
  # (networkmanager and upower are already enabled elsewhere).
  services.power-profiles-daemon.enable = true;

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ noctalia ];
    };
}
