{ config, pkgs, lib, ... }:

{
  programs.aerc.enable = true;
  home.packages = [ pkgs.age ];

  xdg.configFile = {
    "aerc/aerc.conf".source = ./aerc/aerc.conf;
    "aerc/binds.conf".source = ./aerc/binds.conf;
  };

  home.activation.writeAercAccounts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    conf="${config.home.homeDirectory}/.config/aerc/accounts.conf"
    if [ ! -f "$conf" ]; then
      cat > "$conf" << 'AERC_EOF'
# aerc accounts configuration
# passwords are fetched via source-cred-cmd/outgoing-cred-cmd
# using ~/.local/bin/aerc-cred (age-encrypted secrets).
# see https://aerc-mail.org/ for documentation.

[personal]
source = imaps://user@example.com:993
source-cred-cmd = ~/.local/bin/aerc-cred personal
outgoing = smtps://user@example.com:465
outgoing-cred-cmd = ~/.local/bin/aerc-cred personal
default = INBOX
from = Your Name <user@example.com>
copy-to = Sent
AERC_EOF
      chmod 0600 "$conf"
    fi
  '';

  home.file.".local/bin/aerc-cred" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      name="''${1:-personal}"
      key="''${AGE_KEY:-$HOME/.config/age/key.txt}"
      secret="$HOME/.config/aerc/secrets/$name.age"

      if [ ! -f "$secret" ]; then
        echo "aerc-cred: no secret for '$name' at $secret" >&2
        exit 1
      fi

      age -d -i "$key" "$secret"
    '';
    executable = true;
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
