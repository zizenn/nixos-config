{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    programs.skwd-wall.enable = true;
  };
}
