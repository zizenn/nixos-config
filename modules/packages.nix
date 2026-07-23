{...}: {
  perSystem = {pkgs, ...}: {
    packages = with pkgs; {
      inherit
        kitty niri fish neovim waybar rofi wleave mako
        wl-clipboard cliphist
        firefox vesktop
        obs-studio vlc feh imv yazi
        git gh lazygit jujutsu
        starship fzf zoxide bat eza fd ripgrep jq
        tmux fastfetch pavucontrol brightnessctl playerctl
        ;
    };
  };
}
