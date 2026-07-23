{lib, ...}: {
  nixos.modules.base = {
    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };
  };
}
