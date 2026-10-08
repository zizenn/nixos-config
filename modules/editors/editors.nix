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
      programs.zed-editor = {
        enable = true;
        installRemoteServer = true;
      };
      home.packages = with pkgs; [
        opencode

        # NOTE: no LSPs / formatters / toolchains here on purpose.
        # Each project's devenv.nix provides its own (see
        # modules/dev/templates/). Open nvim from inside the
        # activated devenv shell and lspconfig picks them up from PATH.
      ];
      xdg.configFile = {
        "nvim".source = ../neovim/nvim;
        "nvim".recursive = true;
      };
    };
}
