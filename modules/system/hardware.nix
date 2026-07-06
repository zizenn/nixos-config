{ config, lib, pkgs, ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ mesa libva ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
