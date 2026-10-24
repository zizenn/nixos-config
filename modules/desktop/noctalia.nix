{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ noctalia ];

      xdg.configFile = {
        "noctalia".source = ./noctalia;
        "noctalia".recursive = true;
      };
    };
}
