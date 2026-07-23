{lib, ...}: {
  nixos.modules.base = {
    services.logind.settings = {
      Login = {
        HandlePowerKey = "ignore";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
        LidSwitchIgnoreInhibited = "no";
      };
    };
  };
}
