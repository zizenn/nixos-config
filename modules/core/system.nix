{ pkgs, ... }:
{
  time.timeZone = "Australia/Adelaide";
  system.stateVersion = "26.05";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
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
    wget
    xdg-utils
    man-pages
    ntfs3g
  ];

  # Legacy NSS workaround for old CBC ciphers — harmless, keep for compat.
  home-manager.users.zizenn = {
    home.sessionVariables.NSS_SSL_CBC_RANDOM_IV = "0";
  };
}
