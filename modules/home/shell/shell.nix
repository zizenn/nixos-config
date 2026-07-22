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
      ls = "eza -l --icons=always --git --group-directories-first";
      lt = "eza --tree --level=2 --icons=always";
      tree = "eza -T";
      pkgadd = "pkgadd";
      pkgdel = "pkgdel";
      lg = "lazygit";
      lj = "lazyjj";
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
    # 1. Update the variable name inside the main format string
    format = "$directory$git_branch$git_status$fill\${env_var.DEVENV_NAME}$c$cmd_duration$line_break$character";
                                                                                                  
    fill = {
      symbol = " ";
    };
                                                                                                  
    continuation_prompt = "[▸▹ ](dimmed white)";
                                                                                                  
    directory = {
      style = "bold blue";
      format = "[$path]($style)[$read_only]($read_only_style) ";
      truncate_to_repo = true;
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
                                                                                                  
    # 2. Fix the Nix attribute name and Starship internal token
      env_var = {
        DEVENV_NAME = {
          variable = "DEVENV_NAME";
          format = "[ $env_value]($style) ";
          style = "italic bright-blue";
        };
        DEVENV_LANG = {
          variable = "DEVENV_LANG";
          format = "[$env_value]($style) ";
          style = "italic bright-blue";
        };
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
