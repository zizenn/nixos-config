{ config, pkgs, ... }:

{
  textfox = {
      enable = true;
      # Replace with the names of profiles, defined in home-manager, or find existing ones in `about:profiles`
      profiles = ["3w5xd6n1.default"];
      config = {
        background = {
          color = "#123456";
        };
        border = {
          color = "#654321";
          width = "4px";
          transition = "1.0s ease";
          radius = "3px";
        };
        displayWindowControls = true;
        displayNavButtons = true;
        displayUrlbarIcons = true;
        displaySidebarTools = false;
        displayTitles = false;
        newtabLogo = "   __            __  ____          \A   / /____  _  __/ /_/ __/___  _  __\A  / __/ _ \\| |/_/ __/ /_/ __ \\| |/_/\A / /_/  __/>  </ /_/ __/ /_/ />  <  \A \\__/\\___/_/|_|\\__/_/  \\____/_/|_|  ";
        font = {
          family = "JetBrainsMono Nerd Font";
          size = "15px";
          accent = "#654321";
        };
        tabs = {
          horizontal.enable = true;
          vertical.enable = true;
        };
        navbar = {
          margin = "8px 8px 2px";
          padding = "4px";
        };
        bookmarks = {
          alignment = "left";
        };
        icons = {
          toolbar.extensions.enable = true;
          context.extensions.enable = true;
          context.firefox.enable = true;
        };
        textTransform = "uppercase";
        extraConfig = "/* custom css here */";
      };
  };
}
