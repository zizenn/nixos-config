{ config, pkgs, libs, ... }:

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
      config = "cd /etc/nixos";
      home = "nh home switch";
      os = "nh os switch";
      hyprconf = "nvim ~/.config/hypr/hyprland.conf";
      ls = "eza -1";
      tree = "eza -T";
      pkgadd = "~/Documents/scripts/nixpkgsearch.sh";
      pkgdel = "~/Documents/scripts/nixpkgremove.sh";
      code = "claude --model qwen3-coder";
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

        unset ANTHROPIC_API_KEY
        export ANTHROPIC_BASE_URL="http://localhost:11434"
        export ANTHROPIC_AUTH_TOKEN="ollama"
        export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
        export CLAUDE_CODE_ATTRIBUTION_HEADER="0"
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
      '')
    ];
  };
}
