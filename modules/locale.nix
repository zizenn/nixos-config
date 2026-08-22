{lib, ...}: {
  nixos.modules.base = {
    time.timeZone = "Australia/Adelaide";
    system.stateVersion = "26.05";
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
  };
}
