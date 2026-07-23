{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        "mitigations=off"
        "nowatchdog"
        "processor.max_cstate=1"
      ];
      kernel.sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "vm.swappiness" = 1;
        "vm.vfs_cache_pressure" = 50;
        "vm.dirty_background_ratio" = 5;
        "vm.dirty_ratio" = 10;
        "vm.page-cluster" = 0;
        "kernel.numa_balancing" = 0;
        "kernel.unprivileged_userns_clone" = 1;
      };
      initrd.availableKernelModules = [];
    };
  };
}
