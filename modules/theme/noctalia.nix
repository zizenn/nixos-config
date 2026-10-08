{ ... }:
{
  # Noctalia owns theming now: palette source (wallpaper / builtin /
  # community / custom) is picked in Noctalia Settings or via
  # `noctalia msg color-scheme-set`, and Noctalia renders all app
  # templates + reload hooks from theme.toml on every change.
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.file.".local/bin/theme-kanagawa" = {
        executable = true;
        text = ''
          #!${pkgs.fish}/bin/fish
          ${builtins.readFile ../core/scripts/theme-kanagawa}
        '';
      };
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
