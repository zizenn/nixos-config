{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # --- Boot & System ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
  boot.initrd.availableKernelModules = [ "hv_vmbus" "hv_storvsc" "hv_netvsc" ];
  
  networking = {
    hostName = "nix-port";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
    enableIPv6 = false;
    interfaces.wlo1.mtu = 1400;
    networkmanager.dns = "none";
  };

  # networking.firewall.enable = false; # disable firewall

  # --- Graphics (AMD Optimized) ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # --- Desktop Environment & Portals ---
  programs.hyprland.enable = true;
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # --- System Services ---
  services = {
    dbus.enable = true;
    upower.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    udisks2.enable = true;
    displayManager.ly.enable = true;
    openssh.enable = true;
    timesyncd.enable = true;
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
      flake = "/etc/nixos";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      pkgs.vim
      pkgs.neovim
      pkgs.git
      pkgs.htop
      pkgs.kitty
      pkgs.tmux
      pkgs.eza
      pkgs.bubblewrap
      pkgs.firefox
      pkgs.shared-mime-info
      pkgs.glib
      pkgs.xdg-utils
      pkgs.mailcap
      pkgs.cacert
      pkgs.nss
      pkgs.cloudflare-warp
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      NSS_SSL_CBC_RANDOM_IV = "0";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  systemd.packages = [ pkgs.cloudflare-warp ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.firefox.enable = true;
  

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  stdenv.hostPlatform.system.stateVersion = "26.05";
}
