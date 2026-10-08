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
        kitty-single = "kitty --single-instance --listen-on unix:/tmp/kitty-zizenn";
      };
      interactiveShellInit = ''
        set -gx KITTY_LISTEN_ON unix:/tmp/kitty-zizenn
        set -gx STARSHIP_CONFIG ~/.config/starship/noctalia.toml
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
      # NOTE: the prompt itself is rendered by Noctalia's starship user
      # template into $STARSHIP_CONFIG — settings here would be shadowed.
    };
    home.packages = with pkgs; [
      bat bc broot (btop.override {rocmSupport = true;}) catimg cava chafa cmatrix
      eza fd glow ncdu pv ripgrep tldr unzip zip
    ];
  };
}