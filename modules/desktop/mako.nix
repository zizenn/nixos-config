{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    services.mako.enable = true;
    home.packages = with pkgs; [libnotify];
  };
}
