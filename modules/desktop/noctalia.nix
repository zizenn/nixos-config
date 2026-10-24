{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ noctalia ];

      xdg.configFile = {
        "noctalia".source = ./noctalia-con/noctalia/;
        "noctalia".recursive = true;
      };

      home.file = {
      "~/.local/state/noctalia/settings.toml".source = ./noctalia-con/noctalia-config.toml;
      };
    };
}
