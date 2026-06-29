{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  # --- Boot & System ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
  boot.initrd.availableKernelModules = [
    "hv_vmbus"
    "hv_storvsc"
    "hv_netvsc"
  ];

  networking = {
    hostName = "nix-port";
    networkmanager.enable = true;
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    enableIPv6 = false;
    interfaces.wlo1.mtu = 1400;
    networkmanager.dns = "none";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # networking.firewall.enable = false; # disable firewall
  networking.firewall.allowedTCPPorts = [
    9000
    9001
  ];

  # --- Graphics (AMD Optimized) ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # --- Desktop Environment & Portals ---
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-xapp
    ];
    config.common.default = [ "xapp" ];
  };

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  # --- System Services ---
  services = {
    dbus.enable = true;
    upower.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    timesyncd.enable = true;
    elephant.enable = true;
  };

  services.displayManager.ly = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  time.timeZone = "Asia/Dhaka";

  # --- Programs & Environment ---
  programs = {
    zsh.enable = true;
    dconf.enable = true; # Required for browser settings persistence
    nix-ld.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/zizenn/nixos";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      pkgs.vim
      pkgs.neovim
      pkgs.git
      pkgs.btop
      pkgs.kitty
      pkgs.eza
      pkgs.firefox
      pkgs.glib
      pkgs.xdg-utils
      # hyprland ecosystem
      pkgs.brightnessctl
      pkgs.playerctl
      pkgs.wl-clipboard
      pkgs.cliphist
      pkgs.rofi
      pkgs.xhost
      pkgs.waybar
      pkgs.hyprpolkitagent
      pkgs.xdg-desktop-portal-hyprland
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      NSS_SSL_CBC_RANDOM_IV = "0";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };
  security.sudo.enable = false;

  systemd.packages = [ pkgs.cloudflare-warp ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.firefox.enable = true;

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  system.stateVersion = "26.05";
}
