{ ... }: {
  imports = [
    ./udev.nix
    ./logind.nix
    ./ssh.nix
    ./tailscale.nix
    ./usb-resume.nix
    ./misc.nix
    ./ollama.nix
    ./flatpak.nix
  ];
}