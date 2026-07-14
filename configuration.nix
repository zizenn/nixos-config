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
  ];

  # Optimize ext4 on external SSD (USB 3.0) for C++ compilation
  fileSystems."/" = {
    options = [ "noatime" "commit=60" "data=ordered" "barrier=1" ];
  };
}
