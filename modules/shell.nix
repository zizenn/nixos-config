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
    };
    home.packages = with pkgs; [
      bat bc broot btop catimg cava chafa cmatrix
      eza fd glow ncdu pv ripgrep tldr unzip zip
    ];
  };
}
