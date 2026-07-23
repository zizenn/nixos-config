{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [mesa libva vulkan-loader];
      };
    };
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
