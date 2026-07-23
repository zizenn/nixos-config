{lib, ...}: {
  nixos.modules.base = {
    time.timeZone = "Asia/Dhaka";
    system.stateVersion = "26.05";
  };
}
