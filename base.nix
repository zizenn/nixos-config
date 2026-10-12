{ lib, ... }:

{
  imports =
    [
      ./modules/apps
      ./modules/core
      ./modules/desktop
      ./modules/hardware
      ./modules/terminal
    ]
    # Private local-only modules (gitignored, never pushed).
    ++ lib.optional (builtins.pathExists ./modules/_personal) ./modules/_personal;
}
