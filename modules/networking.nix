{ lib, ... }: {
  nixos.modules.base = {
    networking = {
      hostName = "zizenn-hack";
      networkmanager.enable = true;
      networkmanager.dns = "none";
      nameservers = [
        "8.8.8.8"
        "1.1.1.1"
      ];
      enableIPv6 = true;
      interfaces.wlo1.mtu = 1400;
      firewall.allowedTCPPorts = [
        8080
        8081
      ];

      # wake on LAN
      interfaces.enp8s0.wakeOnLan.enable = true;
    };
  };
}
