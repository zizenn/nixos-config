{
  config,
  pkgs,
  libs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Dedicated attribute for environment variables
    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    };

    # 1. Nicer native autocomplete options (Arrow keys + Case-insensitive fuzzy matching)
    completionInit = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format "%F{green}-- %d --%f"
    '';

    # 2. Declaratively add your Zsh plugins via Nix packages
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    # Your custom aliases
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

    initContent = pkgs.lib.mkMerge [
      # High priority (loads first) for Powerlevel10k Instant Prompt
      (pkgs.lib.mkOrder 550 ''
        # Powerlevel10k instant prompt must be evaluated BEFORE any other script sources
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

        # Load P10K Theme script
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '')

      # Standard priority (loads last) for functions, binds, and paths
      (pkgs.lib.mkOrder 1000 ''
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

        # Environment Paths (Kept here because it appends to existing state)
        export PATH="$HOME/.local/bin:$PATH"

        # Runtime styling theme setup
        eval "$(devenv hook zsh)"
        eval "$(zoxide init --cmd cd zsh)"
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '')
    ];
  };
}
