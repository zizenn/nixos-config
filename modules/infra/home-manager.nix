{inputs, lib, ...}: {
  options = {
    homeManager.modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
      default = {};
    };
  };

  config = {
    homeManager.modules.base.imports = [{
      programs.home-manager.enable = true;
    }];
  };
}
