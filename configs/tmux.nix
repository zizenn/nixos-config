{ pkgs, ... }:

{
      
      programs.tmux {
            enable = true;
            prefix = "C-space";

            mouse = true;
            keyMode = "vi";
            baseIndex = 1;
      }

}
