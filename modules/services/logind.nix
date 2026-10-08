{ ... }:
{
  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      LidSwitchIgnoreInhibited = "no";
    };
  };
}
