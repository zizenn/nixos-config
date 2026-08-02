{lib, inputs, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    programs.niri.enable = true;
    services.displayManager.ly.enable = true;
  };

  homeManager.modules.base = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.packages = with pkgs; [
      swayidle swaylock inputs.wlctl.packages.${system}.default
    ];

    programs.swaylock = {
      enable = true;
      settings = {
        color = "181616";
        image = "/home/zizenn/.wallpaper";
        font = "JetBrainsMono Nerd Font";
        clock = true;
        indicator-idle-visible = true;
        ignore-empty-password = true;
        fade-in = 0.2;
        ring-color = "8ba4b0";
        ring-ver-color = "8ea4a2";
        ring-wrong-color = "E82424";
        inside-color = "181616";
        inside-ver-color = "282727";
        inside-wrong-color = "181616";
        key-hl-color = "8ba4b0";
        bs-hl-color = "E82424";
        text-color = "c5c9c5";
        text-ver-color = "8ea4a2";
        text-wrong-color = "E82424";
        line-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        separator-color = "00000000";
      };
    };

    xdg.configFile = {
      "niri/config.kdl".text = let
        fragments = [
          ./niri/01-input.kdl
          ./niri/02-outputs.kdl
          ./niri/03-layout.kdl
          ./niri/04-main.kdl
          ./niri/05-window-rules.kdl
          ./niri/06-binds.kdl
        ];
      in builtins.concatStringsSep "\n" (map builtins.readFile fragments);
    };
  };
}
