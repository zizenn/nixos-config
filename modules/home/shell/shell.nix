{ config, pkgs, ... }:

{

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      conf = "cd ~/nixos";
      home = "nh home switch";
      os = "nh os switch";
      ls = "eza -1";
      tree = "eza -T";
      pkgadd = "pkgadd";
      pkgdel = "pkgdel";
      lg = "lazygit";
      cat = "bat";
      v = "nvim";
      oc = "opencode";
      leet = "nvim leetcode.nvim";
      sudo = "doas";
    };

    # Runs for interactive sessions
    interactiveShellInit = ''
      set -gx MANROFFOPT "-c"
      set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"

      set -U fish_greeting ""
      fish_vi_key_bindings
      fish_add_path ~/.local/bin

      # UWSM integration — source env and provide uwsm-app helper
      type -q uwsm; and uwsm finalize &>/dev/null
      function uwsa --description "Run app under UWSM scope"
        uwsm app -- $argv
      end

      # --- Hooks ---
      # devenv needs to be sourced, it's the only one that can't be "module-ified"
      devenv hook fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      scan_timeout = 50;
      command_timeout = 2000;
      # Added $env_var right after $fill to catch devenv environments
      format = "$directory$git_branch$git_status$fill$env_var$nix_shell$c$cmd_duration$line_break$character";

      fill = {
        symbol = " ";
      };

      continuation_prompt = "[▸▹ ](dimmed white)";

      directory = {
        style = "bold blue";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        truncate_to_repo = false;
      };

      character = {
        success_symbol = "[❯](purple bold)";
        error_symbol = "[❯](red bold)";
        vimcmd_symbol = "[❮](green bold)";
      };

      git_branch = {
        format = "[△ $branch]($style) ";
        style = "italic bright-blue";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold bright-black";
      };

      # Catches devenv environments specifically, styled for Jetpack
      env_var.DEVENV_NAME = {
        variable = "DEVENV_NAME";
        format = "[ $value]($style) ";
        style = "italic bright-blue";
      };

      # Catches standard nix-shell / nix develop environments
      nix_shell = {
        format = "[ \\($state\\)]($style) ";
        style = "italic bright-blue";
      };

      c = {
        format = "[ $version]($style) ";
        style = "italic dimmed white";
      };

      cmd_duration = {
        format = "[$duration]($style)";
        style = "italic dimmed yellow";
      };
    };
  };
}
