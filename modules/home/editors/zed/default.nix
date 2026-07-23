{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
  };

  home.packages = with pkgs; [ claude-code gemini-cli ];

  xdg.configFile = {
    # ensure themes directory exists for matugen to write into
    "zed/themes/.keep".text = "";
    "zed/tasks.json".source = ./tasks.json;
  };
}
