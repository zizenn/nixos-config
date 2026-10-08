{ pkgs, ... }:
{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb;
    motherboard = "amd";
  };
  hardware.i2c.enable = true;

  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ openrgb ];
    };
}
