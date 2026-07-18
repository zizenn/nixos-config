{ config, pkgs, lib, ... }:

{
  programs.aerc.enable = true;
  home.packages = with pkgs; [ age gnupg jq ];

  xdg.configFile = {
    "aerc/aerc.conf".source = ./aerc/aerc.conf;
    "aerc/binds.conf".source = ./aerc/binds.conf;
  };

  home.activation.writeAercAccounts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    conf="${config.home.homeDirectory}/.config/aerc/accounts.conf"
    if [ ! -f "$conf" ]; then
      cat > "$conf" << 'AERC_EOF'
# aerc accounts configuration
# App password auth via age-encrypted credentials.

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

  home.file.".local/bin/aerc-refresh" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      name="''${1:-personal}"
      key="''${AGE_KEY:-$HOME/.config/age/key.txt}"
      state="$HOME/.config/aerc/secrets/$name.app-password"

      [ -f "$state.age" ] || { echo "aerc-refresh: no secret for '$name'" >&2; exit 1; }

      age -d -i "$key" "$state.age" 2>/dev/null || { echo "aerc-refresh: failed to decrypt" >&2; exit 1; }
    '';
    executable = true;
  };

  home.file.".local/bin/aerc-oauth2" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      name="''${1:-personal}"
      key="''${AGE_KEY:-$HOME/.config/age/key.txt}"
      state="$HOME/.config/aerc/secrets/$name.oauth"

      die() { echo "aerc-oauth2: $*" >&2; exit 1; }

      load_state() {
        [ ! -f "$state.age" ] && return
        eval "$(age -d -i "$key" "$state.age" 2>/dev/null)" || die "failed to decrypt $state.age"
      }

      save_state() {
        local tmp; tmp=$(mktemp)
        printf 'client_id=%s\nclient_secret=%s\nrefresh_token=%s\n' \
          "$client_id" "$client_secret" "$refresh_token" > "$tmp"
        age -e -i "$key" -o "$state.age" "$tmp" 2>/dev/null || die "failed to encrypt state"
        rm -f "$tmp"
      }

      device_auth() {
        echo "requesting device code..." >&2
        local resp; resp=$(curl -s -X POST https://oauth2.googleapis.com/device/code \
          -d "client_id=$client_id&scope=https://mail.google.com/") || die "device code request failed"

        local device_code user_code verification_url interval
        device_code=$(echo "$resp" | jq -r '.device_code // empty')
        user_code=$(echo "$resp" | jq -r '.user_code // empty')
        verification_url=$(echo "$resp" | jq -r '.verification_url // empty')
        interval=$(echo "$resp" | jq -r '.interval // 5')

        [ -n "$user_code" ] || die "no user_code: $(echo "$resp" | jq -r '.error_description // .error // empty')"

        echo >&2
        echo "  ┌─────────────────────────────────────────────────────────────" >&2
        echo "  │ authorize aerc to access your gmail:" >&2
        echo "  │" >&2
        echo "  │   1. open  $verification_url" >&2
        echo "  │   2. enter code:  $user_code" >&2
        echo "  │" >&2
        echo "  │ press enter here after authorizing in the browser." >&2
        echo "  └─────────────────────────────────────────────────────────────" >&2
        read -r _

        local grant="urn:ietf:params:oauth:grant-type:device_code"
        while true; do
          sleep "$interval"
          resp=$(curl -s -X POST https://oauth2.googleapis.com/token \
            -d "client_id=$client_id&client_secret=$client_secret&device_code=$device_code&grant_type=$grant") || continue
          refresh_token=$(echo "$resp" | jq -r '.refresh_token // empty')
          [ -n "$refresh_token" ] && break
          local err; err=$(echo "$resp" | jq -r '.error // "pending"')
          [ "$err" != "authorization_pending" ] && [ "$err" != "slow_down" ] && \
            die "auth error: $err"
        done

        save_state
        echo "oauth2 setup complete!" >&2
      }

      get_token() {
        local resp; resp=$(curl -s -X POST https://oauth2.googleapis.com/token \
          -d "client_id=$client_id&client_secret=$client_secret&refresh_token=$refresh_token&grant_type=refresh_token")
        local token; token=$(echo "$resp" | jq -r '.access_token // empty')
        [ -n "$token" ] || die "token refresh failed: $(echo "$resp" | jq -r '.error_description // .error // "unknown"')"
        echo "$token"
      }

      load_state
      [ -n "''${client_id:-}" ] || die "no client_id. create a google cloud oauth2 web application credential first."
      if [ -z "''${refresh_token:-}" ]; then
        device_auth
      fi
      get_token
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
