{ pkgs, ... }:
{
  programs = {
    fish.enable = true;
    dconf.enable = true;
    ccache.enable = true;
    ssh.setXAuthLocation = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "path:/home/zizenn/nixos";
    };
  };

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    nixos.enable = false;
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    xdg-utils
    brightnessctl
    playerctl
    man-pages
    steam-run
    xwayland-satellite
    # Required by nvim-treesitter (main branch) to build/install parsers.
    # GUI-launched nvim must find it on PATH for :TSInstall/:TSUpdate.
    tree-sitter
  ];

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };
}
