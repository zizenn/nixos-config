{lib, ...}: {
  nixos.modules.base = {
    services.tailscale.enable = true;
  };
}
