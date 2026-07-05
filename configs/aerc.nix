{ config, pkgs, ... }:

{
  programs.aerc.enable = true;

  xdg.configFile = {
    "aerc/aerc.conf".source = ./aerc/aerc.conf;
    "aerc/binds.conf".source = ./aerc/binds.conf;
    "aerc/accounts.conf".source = ./aerc/accounts.conf;
  };

  home.file.".local/bin/mail2obsidian.sh" = {
    source = ./mail2obsidian.sh;
    executable = true;
  };

  home.file.".local/bin/aerc-todo-handler" = {
    source = ./aerc-todo-handler;
    executable = true;
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications."x-scheme-handler/aerc-todo" = "aerc-todo.desktop";

  home.file.".local/share/applications/aerc-todo.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Aerc Todo
      Exec=aerc-todo-handler %u
      Type=Application
      MimeType=x-scheme-handler/aerc-todo
      Categories=Network
      Terminal=false
      NoDisplay=true
    '';
  };
}
