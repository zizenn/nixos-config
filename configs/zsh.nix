{
  config,
  pkgs,
  libs,
  ...
}:

{
  programs.zsh = {
    enable = true;

    # Fixed: Updated to the new option name
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh settings
    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [ "git" ];
    };

    # Your custom aliases
    shellAliases = {
      config = "cd ~/nixos";
      home = "nh home switch";
      os = "nh os switch";
      ls = "eza -1";
      tree = "eza -T";
      pkgadd = "~/Documents/scripts/nixpkgsearch.sh";
      pkgdel = "~/Documents/scripts/nixpkgremove.sh";
      lg = "lazygit";
      cat = "bat";
      v = "nvim";
    };

    # Fixed: Merged all shell configurations into the modern initContent system
    initContent = pkgs.lib.mkMerge [
      # High priority (loads first) for Instant Prompt
      (pkgs.lib.mkOrder 550 ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        # Powerlevel10k instant prompt (Must load first)
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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

        # my custom rm function to work with fzf currently disabled cuz it messes with stuff
        remove() {
          # Check if -r or --recursive was passed as the first argument
          if [[ "$1" == "-r" || "$1" == "--recursive" ]]; then
            # Find directories only, exclude hidden ones, and pass to fzf
            # Press TAB to select multiple folders, then Enter to delete
            local targets=$(find . -maxdepth 1 -type d ! -path '.' ! -path '*/.*' | fzf -m --prompt="Select directories to delete: ")
            
            if [ -n "$targets" ]; then
              # Echo the choices first so you see what is happening
              echo "$targets" | xargs -I {} rm -r "{}"
            fi
          else
            # Find files only (no directories, no hidden files)
            local targets=$(find . -maxdepth 1 -type f ! -path '*/.*' | fzf -m --prompt="Select files to delete: ")
            
            if [ -n "$targets" ]; then
              echo "$targets" | xargs -I {} rm "{}"
            fi
          fi
        }

        # OMZ settings (Vi Mode & KeyTimeout)
        bindkey -v
        export KEYTIMEOUT=1

        # Sources & extra integrations
        source <(fzf --zsh)

        # Environment Paths
        export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
        export PATH="$HOME/.local/bin/git-fuzzy/bin:$PATH"
        export MANPAGER="sh -c 'col -bx | bat -l man -p'";
        export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        # Runtime styling theme setup
        eval "$(devenv hook zsh)"
        eval "$(zoxide init --cmd cd zsh)"
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '')
    ];
  };
}
