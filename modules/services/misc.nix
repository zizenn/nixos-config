{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    services = {
      upower.enable = true;
      blueman.enable = true;
      udisks2.enable = true;
      elephant.enable = true;
      fstrim.enable = true;
    };
    systemd.packages = [pkgs.cloudflare-warp];
    services.kmscon = {
      enable = true;
      useXkbConfig = true;
      config = {
        font-name = "JetBrainsMono Nerd Font";
        font-size = 14;
        font-engine = "pango";
        drm = true;
        hwaccel = false;
        term = "xterm-256color";
      };
    };
  };
}
