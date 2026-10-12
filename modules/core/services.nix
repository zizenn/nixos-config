{ ... }:
{
  services = {
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };
    tailscale.enable = true;
    flatpak.enable = true;
  };

  programs.ssh.setXAuthLocation = true;
}
