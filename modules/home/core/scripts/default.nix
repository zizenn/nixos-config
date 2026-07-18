{ config, pkgs, ... }:

{
  home.file = {
    ".local/bin/pkgadd" = {
      executable = true;
      text = ''
#!${pkgs.fish}/bin/fish
${builtins.readFile ./pkgadd}
      '';
    };
    ".local/bin/pkgdel" = {
      executable = true;
      text = ''
#!${pkgs.fish}/bin/fish
${builtins.readFile ./pkgdel}
      '';
    };
  };
}
