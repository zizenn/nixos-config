#!/usr/bin/env bash
# Copy selected files as text/uri-list for drag-and-drop into other apps/websites
set -e
for f in "$@"; do
    echo "file://$(realpath "$f")"
done | wl-copy --type text/uri-list
