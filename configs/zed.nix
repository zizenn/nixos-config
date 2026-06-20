{ config, pkgs, ... }:

{
  xdg.configFile = {
    # ensure themes directory exists for matugen to write into
    "zed/themes/.keep".text = "";
  };
}
