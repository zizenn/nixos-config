{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    programs.waybar.enable = true;
    xdg.configFile = {
      "waybar/config.jsonc".source = ./waybar/config.jsonc;
      "waybar/style.css".source = ./waybar/style.css;

    };
    home.file = {
      ".local/bin/waybar-bt" = {
        executable = true;
        text = ''
          #!${pkgs.bash}/bin/bash
          ${builtins.readFile ./scripts/waybar-bt}
        '';
      };
      ".local/bin/waybar-wifi" = {
        executable = true;
        text = ''
          #!${pkgs.bash}/bin/bash
          ${builtins.readFile ./scripts/waybar-wifi}
        '';
      };
    };
    home.packages = with pkgs; [wttrbar];
  };
}
