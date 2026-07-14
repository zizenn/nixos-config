{ config, pkgs, ... }:

{
  home.file.".local/bin/wallpaper-pick" = {
    executable = true;
    text = ''
      #!${pkgs.fish}/bin/fish
${builtins.readFile ./scripts/wallpaper-pick}
    '';
  };
}
