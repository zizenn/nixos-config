# rofi.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    extraConfig = {
      drun-launch = "uwsm app -- {cmd}";
      run-command = "uwsm app -- {cmd}";
      run-shell-command = "{terminal} -e uwsm app -- {cmd}";
    };
  };
}
