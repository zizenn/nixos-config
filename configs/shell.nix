{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      conf = "cd ~/nixos";
      home = "nh home switch";
      os = "nh os switch";
      ls = "eza -1";
      tree = "eza -T";
      pkgadd = "~/Documents/scripts/nixpkgsearch.sh";
      pkgdel = "~/Documents/scripts/nixpkgremove.sh";
      lg = "lazygit";
      cat = "bat";
      v = "nvim";
      oc = "opencode";
      sudo = "doas";
    };

    # Runs for interactive sessions
    interactiveShellInit = ''
      # --- Environment Variables ---
      set -gx EDITOR "nvim"
      set -gx SUDO_EDITOR "nvim"
      set -gx VISUAL "nvim"
      set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
      set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"

      # --- Devenv & VirtualEnv Overrides ---
      set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
      set -gx DEVENV_NO_PROMPT 1

      # --- Vi Mode ---
      fish_vi_key_bindings

      # --- Paths ---
      fish_add_path ~/.local/bin

      # --- Functions ---
      # Yazi wrapper
      function y
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
      end

      # Custom rm with fzf
      function remove
          if test "$argv[1]" = "-r"; or test "$argv[1]" = "--recursive"
              set targets (find . -maxdepth 1 -type d ! -path '.' ! -path '*/.*' | fzf -m --prompt="Select directories to delete: ")
              if test -n "$targets"
                  for target in $targets
                      rm -r $target
                  end
              end
          else
              set targets (find . -maxdepth 1 -type f ! -path '*/.*' | fzf -m --prompt="Select files to delete: ")
              if test -n "$targets"
                  for target in $targets
                      rm $target
                  end
              end
          end
      end

      # --- Hooks ---
      fzf --fish | source
      zoxide init fish | source
      devenv hook fish | source
    '';

    # Runs on login (Hyprland auto-start)
    loginShellInit = ''
      if uwsm check may-start
        exec uwsm start hyprland-uwsm.desktop
      end
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true; # Keeps your prompt transient

    settings = {
      # Line 1: Directory & Git (Left) -> Space Fill -> Nix, C/C++, Time (Right)
      # Line 2: Typing prompt
      format = "$directory$git_branch$git_status$fill$nix_shell$c$cmd_duration$line_break$character";

      fill = {
        symbol = " ";
      };

      # Jetpack's signature multi-line continuation symbol
      continuation_prompt = "[▸▹ ](dimmed white)";

      directory = {
        style = "bold blue";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        truncate_to_repo = false; # Keeps your p10k full-path preference
      };

      character = {
        success_symbol = "[❯](purple bold)";
        error_symbol = "[❯](red bold)";
        vimcmd_symbol = "[❮](green bold)";
      };

      # Jetpack geometric git style
      git_branch = {
        format = "[△ $branch]($style) ";
        style = "italic bright-blue";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold bright-black";
      };

      # Minimal dev environments (stripped of words)
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
