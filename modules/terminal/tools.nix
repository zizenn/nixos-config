{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bat
        bc
        (btop.override { rocmSupport = true; })
        catimg
        cava
        chafa
        cmatrix
        eza
        fastfetch
        fd
        glow
        herdr
        ncdu
        pv
        ripgrep
        tldr
        unzip
        zip
      ];
      xdg.configFile = {
        "fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
        "herdr/config.toml".text = ''
          onboarding = false
          [theme]
          name = "terminal"
          [ui]
          toast = { delivery = "terminal" }
          [keys]
          prefix = "ctrl+space"
        '';
      };
    };
}
