#!/bin/sh
ws=$(hyprctl activeworkspace -j | jq '.id')
f="/tmp/hypr-layout-$ws"
if [ -f "$f" ]; then
  c=$(cat "$f")
else
  c="scrolling"
fi
if [ "$c" = "dwindle" ]; then
  n="scrolling"
else
  n="dwindle"
fi
echo "$n" > "$f"
hyprctl eval "workspace=$ws, layout=$n"
