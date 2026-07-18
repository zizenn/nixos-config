{ config, pkgs, ... }:

{
  zed-editor = {
    enable = true;
    installRemoteServer = true;
  };

  xdg.configFile = {
    # ensure themes directory exists for matugen to write into
    "zed/themes/.keep".text = "";
    "zed/tasks.json".source = ./tasks.json;
  };
}
