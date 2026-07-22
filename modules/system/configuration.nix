{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./home-manager.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
    ./desktop.nix
    ./services.nix
    ./security.nix
    ./nix.nix
    ./programs.nix
    ./locale.nix
  ];

  fileSystems."/" = {
    options = [ "noatime" "commit=60" "data=ordered" ];
  };
}
