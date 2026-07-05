{ config, pkgs, lib, ... }:

{
  programs.aerc.enable = true;

  xdg.configFile = {
    "aerc/aerc.conf".source = ./aerc/aerc.conf;
    "aerc/binds.conf".source = ./aerc/binds.conf;
  };

  home.activation.writeAercAccounts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    conf="${config.home.homeDirectory}/.config/aerc/accounts.conf"
    cat > "$conf" << 'EOF'
      # aerc accounts configuration
      # replace with your own account settings.
      # see https://aerc-mail.org/ for documentation.

      [personal]
      source = imaps://user@example.com:993
      outgoing = smtps://user@example.com:465
      default = INBOX
      from = Your Name <user@example.com>
      copy-to = Sent
    EOF
    chmod 0600 "$conf"
  '';

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
