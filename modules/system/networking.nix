{ config, lib, pkgs, ... }: {
  networking = {
    hostName = "nix-port";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
    enableIPv6 = false;
    interfaces.wlo1.mtu = 1400;
    firewall.allowedTCPPorts = [ 8080 8081 ];
  };
}
