{ config, lib, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
  boot.initrd.availableKernelModules = [
    "hv_vmbus"
    "hv_storvsc"
    "hv_netvsc"
  ];
}
