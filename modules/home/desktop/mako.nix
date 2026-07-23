{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
  };

  home.packages = with pkgs; [ libnotify ];
}
