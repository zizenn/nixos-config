{ config, pkgs, ... }:

{
  xdg.configFile = {
    # ensure themes directory exists for matugen to write into
    "zed/themes/.keep".text = "";
    "zed/tasks.json".source = ./zed/tasks.json;
  };
}
