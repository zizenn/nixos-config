{lib, ...}: {
  nixos.modules.base = {
    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
      };
    };
  };
}
