{ pkgs, lib, ... }: {
  nixos.modules.base = { pkgs, ... }: {
    programs = {
      fish.enable = true;
      dconf.enable = true;
      firefox.enable = true;
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
  };
}
