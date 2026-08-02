{...}: {
  nixos.modules.base = {...}: {
    boot.initrd.systemd.enable = true;

    swapDevices = [{
      device = "/swapfile";
      size = 16 * 1024;
      options = ["discard"];
    }];
  };
}
