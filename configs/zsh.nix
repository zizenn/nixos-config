{
  config,
  pkgs,
  lib,
  inputs, # Added to pull from flake inputs
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    };

    completionInit = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format "%F{green}-- %d --%f"
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-transient-prompt";
        src = inputs.zsh-transient-prompt;
      }
    ];

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

    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    # Fixed option name and dropped mkMerge bloat
    initExtra = ''
      # Yazi cwd shell wrapper
      function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          command yazi "$@" --cwd-file="$tmp"
          IFS= read -r -d \'\' cwd < "$tmp"
          [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
          rm -f -- "$tmp"
      }

      # Custom rm function with fzf
      remove() {
        if [[ "$1" == "-r" || "$1" == "--recursive" ]]; then
          local targets=$(find . -maxdepth 1 -type d ! -path '.' ! -path '*/.*' | fzf -m --prompt="Select directories to delete: ")
          if [ -n "$targets" ]; then
            echo "$targets" | xargs -I {} rm -r "{}"
          fi
        else
          local targets=$(find . -maxdepth 1 -type f ! -path '*/.*' | fzf -m --prompt="Select files to delete: ")
          if [ -n "$targets" ]; then
            echo "$targets" | xargs -I {} rm "{}"
          fi
        fi
      }

      # Native Zsh Vi Mode & KeyTimeout
      bindkey -v
      export KEYTIMEOUT=1

      # Sources & extra integrations
      source <(fzf --zsh)

      # Environment Paths
      export PATH="$HOME/.local/bin:$PATH"

      # Runtime styling theme setup
      eval "$(devenv hook zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$line_break$character";
      right_format = "$nix_shell$git_branch$git_status$c$cplusplus$cmd_duration";

      directory = {
        style = "cyan bold";
        truncate_to_repo = true;
      };

      character = {
        success_symbol = "[❯](purple bold)";
        error_symbol = "[❯](red bold)";
        vimcmd_symbol = "[❮](green bold)";
      };

      nix_shell = {
        format = "[ $state( \($name\))]($style) ";
        style = "bold blue";
      };

      git_branch = {
        format = "on [ $branch]($style) ";
        style = "bright-black";
      };

      c = {
        format = "via [ $version]($style) ";
        style = "bold text";
      };
      
      cplusplus = {
        format = "via [ $version]($style) ";
        style = "bold text";
      };

      cmd_duration = {
        format = "took [ $duration]($style)";
        style = "yellow";
      };
    };
  };
}
