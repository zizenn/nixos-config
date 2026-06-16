{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # --- Boot & System ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
  
  networking = {
    hostName = "nix-port";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };

  networking.firewall.enable = false;

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
      # inputs.zen-browser.packages.${pkgs.system}.default
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      NSS_SSL_CBC_RANDOM_IV = "0";
    };
  };

  programs.firefox.enable = true;

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
