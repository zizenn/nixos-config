{ config, lib, pkgs, ... }: {
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        mesa.drivers
        libva
        vulkan-loader
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  environment.variables = {
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
