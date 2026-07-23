{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    home.packages = with pkgs; [fastfetch];
    xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
  };
}
