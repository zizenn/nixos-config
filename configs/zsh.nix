{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Native Nix integrations for your missing plugins
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh settings
    ohMyZsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" ]; 
    };

    # Your custom aliases mapped directly to Nix
    shellAliases = {
      config = "cd /etc/nixos";
      home = "nh home switch";
      os = "nh os switch";
    };

    # Instant Prompt (at the very top) and everything else in your original script
    initExtraBeforeCompInit = ''
      # Powerlevel10k instant prompt (Must load first)
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
    '';

    initExtra = ''
      # Yazi cwd shell wrapper
      function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	command yazi "$@" --cwd-file="$tmp"
      	IFS= read -r -d \'\' cwd < "$tmp"
      	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
      	rm -f -- "$tmp"
      }

      # OMZ settings (Vi Mode & KeyTimeout)
      bindkey -v
      export KEYTIMEOUT=1

      # Sources & extra integrations
      source <(fzf --zsh)

      # Environment Paths
      export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      # Runtime styling theme setup
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}

