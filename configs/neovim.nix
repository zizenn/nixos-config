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
    "nvim/lua/plugins/telescope.lua".source = ./nvim/plugins/telescope.lua;
    "nvim/lua/plugins/neotree.lua".source = ./nvim/plugins/neotree.lua;
    "nvim/lua/plugins/treesitter.lua".source = ./nvim/plugins/treesitter.lua;
    "nvim/lua/plugins/whichkey.lua".source = ./nvim/plugins/whichkey.lua;
    "nvim/lua/plugins/lualine.lua".source = ./nvim/plugins/lualine.lua;
    "nvim/lua/plugins/bufferline.lua".source = ./nvim/plugins/bufferline.lua;
    "nvim/lua/plugins/indent-blankline.lua".source = ./nvim/plugins/indent-blankline.lua;
    "nvim/lua/plugins/autopairs.lua".source = ./nvim/plugins/autopairs.lua;
    "nvim/lua/plugins/comment.lua".source = ./nvim/plugins/comment.lua;
    "nvim/lua/plugins/gitsigns.lua".source = ./nvim/plugins/gitsigns.lua;
    "nvim/lua/plugins/surround.lua".source = ./nvim/plugins/surround.lua;
    "nvim/lua/plugins/todo-comments.lua".source = ./nvim/plugins/todo-comments.lua;
    "nvim/lua/plugins/toggleterm.lua".source = ./nvim/plugins/toggleterm.lua;
  };
}
