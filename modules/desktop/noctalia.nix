{ ... }:
{
  # Noctalia v5 (nixpkgs `noctalia`, NOT legacy quickshell `noctalia-shell`)
  # replaces waybar + mako + rofi + wleave — shell package, theme
  # templates, and settings all live here.
  # Template settings live in ~/.config/noctalia/ and are managed via the
  # Noctalia Settings GUI (or `programs.noctalia.settings` if we later
  # pin the upstream flake for its home-manager module).

  # Required for Noctalia's wifi / power-profile / battery features
  # (networkmanager and upower are already enabled elsewhere).
  services.power-profiles-daemon.enable = true;

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ noctalia ];

      xdg.configFile = {
        "noctalia/theme.toml".source = ./noctalia/theme.toml;
        "noctalia/templates/gtk.css".source = ./noctalia/templates/gtk.css;
        "noctalia/templates/Noctalia.kvconfig".source = ./noctalia/templates/Noctalia.kvconfig;
        "noctalia/templates/starship.toml".source = ./noctalia/templates/starship.toml;
        "noctalia/templates/nvim-colors.json".source = ./noctalia/templates/nvim-colors.json;
        "noctalia/templates/zed.json".source = ./noctalia/templates/zed.json;
        "noctalia/templates/obsidian.css".source = ./noctalia/templates/obsidian.css;
        "noctalia/templates/vesktop.css".source = ./noctalia/templates/vesktop.css;
        "noctalia/templates/swaylock.conf".source = ./noctalia/templates/swaylock.conf;
      };
    };
}
