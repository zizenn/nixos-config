{ ... }:
{
  programs.ccache.enable = true;

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "zizenn-pc";
            email = "zizenn.69@gmail.com";
          };
          core.editor = "nvim";
        };
      };

      home.packages = with pkgs; [
        gh
        lazygit
        devenv
        cppman
      ];
    };
}
