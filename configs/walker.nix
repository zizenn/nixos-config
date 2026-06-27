{ inputs, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      theme = "matugen";
      placeholders."default" = {
        input = "Search...";
        list = "Pinned";
      };
      providers.list = [
        {
          name = "Zen Browser";
          exec = "zen";
          icon = "zen-browser";
        }
        {
          name = "Kitty";
          exec = "kitty";
          icon = "kitty";
        }
        {
          name = "LocalSend";
          exec = "localsend";
          icon = "localsend";
        }
        {
          name = "Bluetooth";
          exec = "blueman-manager";
          icon = "blueman";
        }
      ];
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = ";";
        }
        {
          provider = "list";
          prefix = "!";
        }
      ];
    };

    # This sets up the theme directory structure under ~/.config/walker/themes/matugen/
    # matugen will overwrite style.css at runtime with real colors.
    # The content here acts as a fallback before matugen runs.
    themes."matugen" = {
      style = ''
        * {
          all: unset;
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-size: 14px;
        }

        #window {
          background-color: @bg;
          color: @fg;
          border-radius: 18px;
          padding: 12px;
          min-width: 480px;
        }

        #search {
          background-color: @surface_variant;
          color: @fg;
          border-radius: 12px;
          padding: 10px 14px;
          margin-bottom: 8px;
        }

        #search:focus {
          outline: 2px solid @primary;
        }

        .item {
          background-color: transparent;
          color: @fg;
          border-radius: 10px;
          padding: 8px 12px;
        }

        .item:hover,
        .item:selected {
          background-color: @surface_variant;
          color: @fg;
        }

        .item .label {
          color: @fg;
        }

        .item .sub {
          color: @fg_muted;
          font-size: 12px;
        }
      '';
    };
  };
}
