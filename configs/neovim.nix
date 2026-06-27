{ config, pkgs, ... }:

let
  theme = "matugen";
in
{
  xdg.configFile = {
    "nvim/.stylua.toml".source = ./nvim/.stylua.toml;
    "nvim/.selene.toml".source = ./nvim/.selene.toml;
    "nvim/init.lua".source = ./nvim/init.lua;

    "nvim/lua/matugen/init.lua".source = ./nvim/lua/matugen/init.lua;
    "nvim/lua/kanagawa-dragon/init.lua".source = ./nvim/lua/kanagawa-dragon/init.lua;

    "nvim/lua/plugins/theme.lua".source = ./nvim/plugins/theme.lua;
    "nvim/colors/matugen.lua".source = ./nvim/colors/matugen.lua;

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
    "nvim/lua/plugins/copilot.lua".source = ./nvim/plugins/copilot.lua;
    "nvim/lua/plugins/gitsigns.lua".source = ./nvim/plugins/gitsigns.lua;
    "nvim/lua/plugins/todo-comments.lua".source = ./nvim/plugins/todo-comments.lua;
    "nvim/lua/plugins/toggleterm.lua".source = ./nvim/plugins/toggleterm.lua;
    "nvim/lua/plugins/mason.lua".source = ./nvim/plugins/mason.lua;
    "nvim/lua/plugins/blink.lua".source = ./nvim/plugins/blink.lua;
    "nvim/lua/plugins/comment.lua".source = ./nvim/plugins/comment.lua;
    "nvim/lua/plugins/fidget.lua".source = ./nvim/plugins/fidget.lua;
    "nvim/lua/plugins/telekasten.lua".source = ./nvim/plugins/telekasten.lua;
    "nvim/lua/plugins/markdown-preview.lua".source = ./nvim/plugins/markdown-preview.lua;

    "nvim/lua/plugins/conform.lua".source = ./nvim/plugins/conform.lua;
    "nvim/lua/plugins/lint.lua".source = ./nvim/plugins/lint.lua;
    "nvim/lua/plugins/mini.lua".source = ./nvim/plugins/mini.lua;
    "nvim/lua/plugins/flash.lua".source = ./nvim/plugins/flash.lua;
    "nvim/lua/plugins/vimade.lua".source = ./nvim/plugins/vimade.lua;
    "nvim/lua/plugins/remember.lua".source = ./nvim/plugins/remember.lua;
    "nvim/lua/plugins/scrolleof.lua".source = ./nvim/plugins/scrolleof.lua;
  };
}
