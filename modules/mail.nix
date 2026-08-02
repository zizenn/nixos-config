{...}: {
  homeManager.modules.base = {...}: {
    programs.aerc.enable = true;
    xdg.configFile = {
      "aerc/aerc.conf".source = ./aerc/aerc.conf;
      "aerc/accounts.conf".source = ./aerc/accounts.conf;
      "aerc/binds.conf".source = ./aerc/binds.conf;
    };
  };
}
