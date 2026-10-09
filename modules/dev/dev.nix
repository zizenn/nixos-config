{ ... }:
{
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
      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "zizenn-pc";
            email = "zizenn.69@gmail.com";
          };
          ui.default-editor = "nvim";
        };
      };
      home.packages = with pkgs; [
        gh
        lazygit
        lazyjj
        devenv
        cppman
        jq
        nix-search-cli
        socat
      ];
    };
}
