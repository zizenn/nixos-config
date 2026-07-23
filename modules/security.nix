{lib, ...}: {
  nixos.modules.base = {
    security.doas = {
      enable = true;
      extraRules = [{
        groups = ["wheel"];
        keepEnv = true;
        persist = true;
      }];
    };
    security.sudo.enable = false;
    nixpkgs.config.allowUnfree = true;
  };
}
