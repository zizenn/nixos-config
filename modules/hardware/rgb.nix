{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb;
      motherboard = "amd";
    };
    hardware.i2c.enable = true;
  };
  homeManager.modules.base = {pkgs, ...}: {
    home.packages = with pkgs; [openrgb];
  };
}
