{ config, pkgs, ... }:

let
  niriConfig = builtins.toFile "config.kdl" ''
    prefer-no-csd true

    input {
        keyboard {
            xkb {
                layout "us"
                options "ctrl:nocaps"
            }
        }
    }

    layout {
        gaps 8
        border {
            enable true
            width 2
            active {
                gradient {
                    angle 135
                    stops [
                        { color "#89b4fa" }
                        { color "#cba6f7" }
                    ]
                }
            }
            inactive "#45475a"
        }
    }

    window-rule {
        geometry-match corner "all"
        draw-border-with-background true
    }
    window-rule {
        open-floating true
        match app-id "^pavucontrol$"
    }
    window-rule {
        open-floating true
        match app-id "^blueman-manager$"
    }
    window-rule {
        open-floating true
        match app-id "^xdg-desktop-portal"
    }
    window-rule {
        open-floating true
        match app-id "^wleave$"
    }
    window-rule {
        open-floating true
        match app-id "^rofi$"
    }
    window-rule {
        open-floating true
        match app-id "^pinentry-"
    }
    window-rule {
        open-floating true
        match app-id "^org\\.keepassxc"
    }
    window-rule {
        open-floating true
        match app-id "^mpv$"
    }
    window-rule {
        open-floating true
        match app-id "^vlc$"
    }
    window-rule {
        open-float true
        block-outside-focus true
        match app-id "^zen_zen$"
    }

    binds {
        Super+Q { close-window; }
        Super+T { spawn "kitty"; }
        Super+E { spawn "kitty" "--class" "yazi-float" "-e" "yazi"; }
        Super+D { spawn "rofi" "-show" "drun"; }
        Super+Alt+D { spawn "rofi" "-show" "run"; }
        Super+V { spawn "cliphist-rofi-img"; }
        Super+W { spawn "theme-wallpaper"; }
        Super+P { spawn "wleave"; }
        Super+A { spawn "kitty" "--class" "aerc-float" "-e" "aerc"; }
        Super+O { spawn "obsidian"; }
        Super+M { spawn "kitty" "-e" "nh" "os" "switch"; }
        Super+F { toggle-window-floating; }
        Super+Shift+F { fullscreen-window; }
        Super+Q { close-window; }

        Super+h { focus-column-left; }
        Super+l { focus-column-right; }
        Super+j { focus-workspace-down; }
        Super+k { focus-workspace-up; }

        Super+Shift+h { move-column-left; }
        Super+Shift+l { move-column-right; }
        Super+Shift+j { move-workspace-down; }
        Super+Shift+k { move-workspace-up; }

        Super+1 { focus-workspace 1; }
        Super+2 { focus-workspace 2; }
        Super+3 { focus-workspace 3; }
        Super+4 { focus-workspace 4; }
        Super+5 { focus-workspace 5; }
        Super+6 { focus-workspace 6; }
        Super+7 { focus-workspace 7; }
        Super+8 { focus-workspace 8; }
        Super+9 { focus-workspace 9; }

        Super+Shift+1 { move-column-to-workspace 1; }
        Super+Shift+2 { move-column-to-workspace 2; }
        Super+Shift+3 { move-column-to-workspace 3; }
        Super+Shift+4 { move-column-to-workspace 4; }
        Super+Shift+5 { move-column-to-workspace 5; }
        Super+Shift+6 { move-column-to-workspace 6; }
        Super+Shift+7 { move-column-to-workspace 7; }
        Super+Shift+8 { move-column-to-workspace 8; }
        Super+Shift+9 { move-column-to-workspace 9; }

        Super+Comma { focus-workspace-prev; }
        Super+Period { focus-workspace-next; }

        Super+Shift+Slash { debug-toggle-overlay; }

        XF86AudioRaiseVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"; }
        XF86AudioLowerVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"; }
        XF86AudioMute { spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"; }
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioPause { spawn "playerctl" "pause"; }
        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
    }

    binds {
        Super { drag-column; }
        Super+Shift { drag-window; }
    }
  '';
in {
  xdg.configFile = {
    "niri/config.kdl".source = niriConfig;
    "hypr/hypridle.conf".source = ./hypridle.conf;
  };

  home.file.".local/bin/layout-toggle.sh".source = ./layout-toggle.sh;
}
