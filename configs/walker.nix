# configs/walker.nix
{ inputs, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true; # keeps walker pre-warmed, instant open
    config = {
      placeholders."default".input = "Search...";
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = ";";
        }
      ];
    };
  };
}
