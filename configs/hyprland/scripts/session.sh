#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/hypr-session"
STATE_FILE="$STATE_DIR/state.json"

# Background services / daemons to exclude from snapshot
EXCLUDE=(
  waybar rofi hypridle hyprlock hyprpaper skwd-daemon
  xdg-desktop-portal cliphist polkit-kde-authentication-agent
  hyprpolkitagent wleave matugen ollama nm-applet blueman-applet
)

# Known class → launch command (use /proc fallback for anything not listed)
declare -A MAP
MAP=(
  [kitty]=kitty
  [zen-browser]=zen-browser
  [firefox]=firefox
  [obsidian]=obsidian
  [vesktop]=vesktop
  [vlc]=vlc
  [pavucontrol]=pavucontrol
  [steam]=steam
  [thunar]=thunar
  [zathura]=zathura
  [Alacritty]=alacritty
  [Code]=code
  [codium]=codium
  [brave-browser]=brave
  [yazi-float]="kitty --class yazi-float -e yazi"
  [aerc-todo]="kitty --class aerc-todo -e aerc"
)

save() {
  mkdir -p "$STATE_DIR"

  local exclude_re
  exclude_re=$(IFS='|'; echo "${EXCLUDE[*]}")

  hyprctl clients -j | jq -c '.[]' | while read -r c; do
    local cls title ws pid cmd
    cls=$(jq -r '.class' <<<"$c")
    title=$(jq -r '.title' <<<"$c")
    ws=$(jq -r '.workspace.id // 0' <<<"$c")
    pid=$(jq -r '.pid // 0' <<<"$c")

    grep -qiE "^($exclude_re)$" <<<"$cls" && continue
    [[ "$ws" -le 0 ]] && continue

    cmd="${MAP[$cls]:-}"
    if [[ -z "$cmd" && "$pid" -gt 0 ]]; then
      cmd=$(ps -o args= -p "$pid" 2>/dev/null | head -1) || true
      cmd=$(sed 's|^/nix/store/[^/]*/bin/||' <<<"$cmd")
      cmd=$(sed 's|^bin/||' <<<"$cmd")
    fi
    [[ -z "$cmd" ]] && continue

    jq -nc --argjson w "$ws" --arg c "$cls" --arg t "$title" --arg m "$cmd" \
      '{workspace: $w, class: $c, title: $t, cmd: $m}'
  done | jq -s 'sort_by(.workspace)' > "$STATE_FILE"

  local n
  n=$(jq length "$STATE_FILE")
  notify-send "Session saved" "$n windows on $(jq '[.[].workspace] | unique | length' "$STATE_FILE") workspaces" -t 3000
}

restore() {
  if [[ ! -f "$STATE_FILE" ]]; then
    notify-send "Session restore" "No saved session found" -t 3000
    return
  fi

  local n
  n=$(jq length "$STATE_FILE")
  notify-send "Session restore" "Restoring $n windows…" -t 3000

  jq -c '.[]' "$STATE_FILE" | while read -r entry; do
    local ws cmd
    ws=$(jq -r '.workspace' <<<"$entry")
    cmd=$(jq -r '.cmd' <<<"$entry")

    hyprctl dispatch workspace "$ws"
    sleep 0.15
    hyprctl dispatch exec -- "$cmd"
    sleep 0.15
  done

  notify-send "Session restored" "$n windows restored" -t 3000
}

case "${1:-}" in
  save)    save ;;
  restore) restore ;;
  *)       echo "Usage: $0 {save|restore}"; exit 1 ;;
esac
