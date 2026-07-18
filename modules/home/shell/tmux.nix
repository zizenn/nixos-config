{ pkgs, config, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-space";
    terminal = "tmux-256color";

    mouse = true;
    keyMode = "vi";
    baseIndex = 1;

    extraConfig = ''
      set-option -sa terminal-features ',xterm-256color:RGB'
    '';
  };
}
