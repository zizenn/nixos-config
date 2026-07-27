{lib, ...}: {
  homeManager.modules.base = {pkgs, inputs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    programs.prismlauncher.enable = true;
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs obs-pipewire-audio-capture obs-vkcapture obs-vaapi
      ];
    };
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      plugins = {
        drag = pkgs.yaziPlugins.drag;
        ouch = pkgs.yaziPlugins.ouch;
      };
      settings = {
        mgr = {
          ratio = [1 3 4];
          sort_by = "natural";
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
          show_hidden = false;
        };
        input.cursor_blink = true;
      };
      keymap = {
        manager.prepend_keymap = [{
          on = ["<C-g>"];
          run = "plugin drag";
          desc = "Drag selected files out of Yazi via ripdrag";
        }];
      };
    };
    home.packages = with pkgs; [
      glaxnimate kdePackages.kdenlive mediainfo obsidian ollama
      pandoc pavucontrol proton-pass protonmail-desktop steam vesktop
      vlc zathura inputs.zen-browser.packages.${system}.default ripdrag
    ];
    xdg.desktopEntries.yazi = {
      name = "yazi";
      exec = "kitty --class yazi-float -e yazi %u";
      terminal = false;
      mimeType = ["inode/directory"];
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["yazi.desktop"];
      };
    };
  };
}
