{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
      home.packages = with pkgs; [
        opencode
        tree-sitter # required for nvim
      ];
      xdg.configFile = {
        "nvim".source = ./neovim/nvim;
        "nvim".recursive = true;
      };
    };
}
