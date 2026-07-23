{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
