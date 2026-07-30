{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    programs.waybar.enable = true;
    xdg.configFile = {
      "waybar/config.jsonc".source = ./waybar/config.jsonc;
      "waybar/style.css".source = ./waybar/style.css;

    };
    home.packages = with pkgs; [wttrbar];
  };
}
