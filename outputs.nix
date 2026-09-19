inputs: let
  inherit (inputs.nixpkgs) lib;

  modules = [
    ./modules/host.nix
    ./modules/audio
    ./modules/boot
    ./modules/desktop
    ./modules/dev
    ./modules/editors
    ./modules/hardware
    ./modules/locale
    ./modules/networking
    ./modules/nix
    ./modules/packages
    ./modules/programs
    ./modules/security
    ./modules/services
    ./modules/shell
    ./modules/swap
    ./modules/infra
    ./modules/apps
    ./modules/theme
    ./modules/misc
    ./modules/_personal
  ];

  evaluation = inputs.flake-parts.lib.evalFlakeModule {inherit inputs;} {
    imports = modules;
    systems = ["x86_64-linux"];
  };
in
  {inherit evaluation;} // evaluation.config.processedFlake