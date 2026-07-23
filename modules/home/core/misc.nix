{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awww
    bluetui
    herdr
    ntfs3g
    wiremix
  ];
}
