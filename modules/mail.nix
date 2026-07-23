{lib, ...}: {
  homeManager.modules.base = {pkgs, config, lib, ...}: {
    programs.aerc.enable = true;
    home.packages = with pkgs; [age gnupg jq];
    xdg.configFile = {
      "aerc/aerc.conf".source = ./aerc/aerc.conf;
      "aerc/binds.conf".source = ./aerc/binds.conf;
    };
    home.activation.writeAercAccounts = lib.hm.dag.entryAfter ["writeBoundary"] ''
      conf="${config.home.homeDirectory}/.config/aerc/accounts.conf"
      if [ ! -f "$conf" ]; then
        cat > "$conf" << 'AERC_EOF'
    [personal]
    source = imaps://zizenn.69%40gmail.com@imap.gmail.com:993
    source-cred-cmd = ~/.local/bin/aerc-refresh personal
    outgoing = smtps://zizenn.69%40gmail.com@smtp.gmail.com:465
    outgoing-cred-cmd = ~/.local/bin/aerc-refresh personal
    default = INBOX
    from = Zizenn <zizenn.69@gmail.com>
    copy-to = Sent
    AERC_EOF
        chmod 0600 "$conf"
      fi
    '';
    home.file = {
      ".local/bin/aerc-refresh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          set -euo pipefail
          name="''${1:-personal}"
          key="''${AGE_KEY:-$HOME/.config/age/key.txt}"
          state="$HOME/.config/aerc/secrets/$name.app-password"
          [ -f "$state.age" ] || { echo "aerc-refresh: no secret for '$name'" >&2; exit 1; }
          age -d -i "$key" "$state.age" 2>/dev/null || { echo "aerc-refresh: failed to decrypt" >&2; exit 1; }
        '';
      };
      ".local/bin/aerc-oauth2" = {
        executable = true;
        source = ./aerc/aerc-oauth2;
      };
      ".local/bin/mail2obsidian.sh" = {
        executable = true;
        source = ./aerc/mail2obsidian.sh;
      };
      ".local/bin/aerc-todo-handler" = {
        executable = true;
        source = ./aerc/aerc-todo-handler;
      };
      ".local/share/applications/aerc-todo.desktop".text = ''
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
    xdg.mimeApps.enable = true;
    xdg.mimeApps.defaultApplications."x-scheme-handler/aerc-todo" = "aerc-todo.desktop";
  };
}
