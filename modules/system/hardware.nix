{ config, lib, pkgs, ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ mesa libva vulkan-loader ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
