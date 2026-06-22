{ config, pkgs, ... }:

let
  # Toggle your active theme here: "matugen" or "kanagawa"
  theme = "matugen";
in
{
  xdg.configFile = {
    # 1. The main entrypoint
    "nvim/init.lua".source = ./nvim/init.lua;

    # 2. Core Theme Modules
    "nvim/lua/matugen/init.lua".source = ./nvim/lua/matugen/init.lua;
    "nvim/lua/kanagawa-dragon/init.lua".source = ./nvim/lua/kanagawa-dragon/init.lua;

    # 3. Theme Spec and Native Colorscheme Bridges
    "nvim/lua/plugins/theme.lua".source = ./nvim/plugins/theme.lua;
    "nvim/colors/matugen.lua".source = ./nvim/colors/matugen.lua;

    # 4. Core IDE Plugins
    "nvim/lua/plugins/lsp.lua".source = ./nvim/plugins/lsp.lua;
    "nvim/lua/plugins/dap.lua".source = ./nvim/plugins/dap.lua;
    "nvim/lua/plugins/noice.lua".source = ./nvim/plugins/noice.lua;
    "nvim/lua/plugins/dashboard.lua".source = ./nvim/plugins/dashboard.lua;
  };
}
