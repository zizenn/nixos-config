{lib, inputs, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    programs.niri.enable = true;
    services.displayManager.ly.enable = true;
  };

  homeManager.modules.base = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    home.packages = with pkgs; [
      hypridle hyprlock swaylock inputs.wlctl.packages.${system}.default
    ];

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
      "hypr/hypridle.conf".source = ./niri/hypridle.conf;
    };
  };
}
