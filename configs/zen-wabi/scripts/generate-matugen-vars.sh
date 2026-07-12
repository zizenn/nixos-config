#!/usr/bin/env bash
set -euo pipefail

# Generate matugen-vars.json and rendered CSS for zen-wabi
# Reads matugen JSON output and writes files to the Zen profile chrome dir.

WALLPAPER="${1:-}"
if [ -z "$WALLPAPER" ]; then
	WALLPAPER="$HOME/.wallpaper"
fi

ZEN_PROFILE="${2:-}"
if [ -z "$ZEN_PROFILE" ]; then
	# find the most recently modified Zen profile
	ZEN_PROFILE=$(ls -td "$HOME/.config/zen/"*.Default* 2>/dev/null | head -1)
fi

CHROME_DIR="$ZEN_PROFILE/chrome"
TEMPLATES_DIR="${3:-${XDG_CONFIG_HOME:-$HOME/.config}/zen/templates}"

mkdir -p "$CHROME_DIR"

# Run matugen to get JSON color data
MATUGEN_JSON=$(matugen image --json hex --dry-run --prefer saturation "$WALLPAPER" 2>/dev/null)

if [ -z "$MATUGEN_JSON" ]; then
	notify-send "zen-wabi" "matugen failed to generate colors"
	exit 1
fi

# Extract colors from matugen JSON
get_color() {
	echo "$MATUGEN_JSON" | jq -r ".colors.$1.dark.color // \"$2\""
}

ACCENT=$(get_color "primary" "#fcb974")
BG=$(get_color "background" "#19120c")
BG_DARK=$(get_color "surface_container_high" "#261e18")
BG_LIGHT=$(get_color "surface_variant" "#50453a")
FG=$(get_color "on_background" "#eee0d5")
FG_LIGHT=$(get_color "on_surface_variant" "#cdb89e")
SECONDARY=$(get_color "secondary_container" "#3a3027")
TERTIARY=$(get_color "outline_variant" "#5a4c40")

# Write matugen-vars.json
cat > "$CHROME_DIR/matugen-vars.json" <<EOF
{
  "accent": "$ACCENT",
  "bg": "$BG",
  "bg_dark": "$BG_DARK",
  "bg_light": "$BG_LIGHT",
  "fg": "$FG",
  "fg_light": "$FG_LIGHT",
  "secondary": "$SECONDARY",
  "tertiary": "$TERTIARY"
}
EOF

# Render templates if they exist
render_template() {
	local template="$1"
	local output="$2"
	if [ -f "$template" ]; then
		sed \
			-e "s/{{bg}}/$BG/g" \
			-e "s/{{bg_dark}}/$BG_DARK/g" \
			-e "s/{{bg_light}}/$BG_LIGHT/g" \
			-e "s/{{fg}}/$FG/g" \
			-e "s/{{fg_light}}/$FG_LIGHT/g" \
			-e "s/{{accent}}/$ACCENT/g" \
			-e "s/{{secondary}}/$SECONDARY/g" \
			-e "s/{{tertiary}}/$TERTIARY/g" \
			"$template" > "$output"
	fi
}

# Render userChrome.css for initial paint defaults
render_template "$TEMPLATES_DIR/userChrome.css.template" "$CHROME_DIR/userChrome.css"

# Render content CSS
render_template "$TEMPLATES_DIR/userContent.css.template" "$CHROME_DIR/matugen-userstyles.css"
render_template "$TEMPLATES_DIR/userContent.github.template" "$CHROME_DIR/matugen-userstyles-github.css"
