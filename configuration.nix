{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/system/boot.nix
    ./modules/system/networking.nix
    ./modules/system/hardware.nix
    ./modules/system/desktop.nix
    ./modules/system/services.nix
    ./modules/system/security.nix
    ./modules/system/nix.nix
    ./modules/system/programs.nix
    ./modules/system/locale.nix
    inputs.sysc-greet.nixosModules.default
  ];
}
