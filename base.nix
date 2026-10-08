{ lib, ... }:

{
  imports =
    [
      ./modules/apps
      ./modules/audio
      ./modules/boot
      ./modules/desktop
      ./modules/dev
      ./modules/editors
      ./modules/hardware
      ./modules/locale
      ./modules/misc
      ./modules/networking
      ./modules/nix
      ./modules/programs
      ./modules/security
      ./modules/services
      ./modules/shell
      ./modules/swap
      ./modules/theme
    ]
    # Private local-only modules (gitignored, never pushed).
    ++ lib.optional (builtins.pathExists ./modules/_personal) ./modules/_personal;
}
