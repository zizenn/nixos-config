{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true; # required by programs.steam (_personal/programs.nix)
      extraPackages = with pkgs; [ mesa libva vulkan-loader ];
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}
