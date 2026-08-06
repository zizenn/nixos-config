{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
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
        os = "nh os switch path:/home/zizenn/nixos";
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
      interactiveShellInit = ''
        set -gx STARSHIP_CONFIG ~/.config/starship/matugen.toml
        set -gx MANROFFOPT "-c"
        set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
        set -U fish_greeting ""
        fish_vi_key_bindings
        fish_add_path ~/.local/bin
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
        format = "$directory$git_branch$git_status$fill${"\n"}$character";
        fill.symbol = " ";
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
        cmd_duration = {
          format = "[$duration]($style)";
          style = "italic dimmed yellow";
        };
      };
    };
    home.packages = with pkgs; [
      bat bc broot btop catimg cava chafa cmatrix
      eza fd glow ncdu pv ripgrep tldr unzip zip
    ];
  };
}
