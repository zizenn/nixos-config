{ lib, ... }: {
  nixos.modules.base = { pkgs, ... }: {
    services.flatpak.enable = true;
  };
}
