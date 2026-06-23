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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-xapp ];
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
  };

  systemd.services.tty-palette = {
    description = "Set TTY palette for Kanagawa Dragon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      # \e]P0181616 sets background to dragonBlack3
      # \e]P7DCD7BA sets foreground to fujiWhite
      # \ec resets the TTY to apply changes
      ExecStart = "${pkgs.coreutils}/bin/printf '\\e]P0181616\\e]P7DCD7BA\\ec'";
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      hide_greeting = true;
      clock = "%H:%M:%S";
      # Ly UI specific colors
      bg = "#181616";
      fg = "#DCD7BA";
      save = true;
      animate = false;
    };
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
      flake = "~/nixos";
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
      # more pkgs
      pkgs.terminus_font
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
  

  # tty fonts
  console.keyMap = "us"; 
  # 'ter-v16n' (Terminus) is available in the 'terminus_font' package.
  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psf.gz";

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
  system.stateVersion = "26.05";
}
