{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    programs = {
      fish.enable = true;
      dconf.enable = true;
      firefox.enable = true;
      ccache.enable = true;
      ssh.setXAuthLocation = true;
      java = {
        enable = true;
        package = pkgs.temurin-bin-21;
      };
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/zizenn/nixos";
      };
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };

    documentation = {
      enable = true;
      doc.enable = false;
      man.enable = true;
      nixos.enable = false;
    };

    fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono];

    environment.systemPackages = with pkgs; [
      vim wget xdg-utils brightnessctl playerctl cliphist
      man-pages steam-run temurin-bin-21 temurin-bin-17 xwayland
    ];

    users.users.zizenn = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "video"];
      shell = pkgs.fish;
    };
  };
}
