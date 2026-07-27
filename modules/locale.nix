{lib, ...}: {
  nixos.modules.base = {
    time.timeZone = "Australia/Adelaide";
    system.stateVersion = "26.05";
  };
}
