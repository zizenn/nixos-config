{ config, pkgs, ... }:

let
  # Theme selection: "matugen" or "kanagawa-dragon"
  theme = "matugen";
in
{
  xdg.configFile = {
    # Core theme definitions
    "nvim/lua/matugen/init.lua".source = ./nvim/lua/matugen/init.lua;
    "nvim/lua/kanagawa-dragon/init.lua".source = ./nvim/lua/kanagawa-dragon/init.lua;

    # Dynamic theme plugin loading based on the Nix variable
    "nvim/lua/plugins/theme.lua".source = 
      if theme == "matugen" 
      then ./nvim/plugins/theme-matugen.lua 
      else ./nvim/plugins/theme-kanagawa.lua;

    # Other UI and IDE Plugins
    "nvim/lua/plugins/noice.lua".source = ./nvim/plugins/noice.lua;
    "nvim/lua/plugins/lsp.lua".source = ./nvim/plugins/lsp.lua;
    "nvim/lua/plugins/dap.lua".source = ./nvim/plugins/dap.lua;
  };
}
