{config, lib, inputs, ...}: let
  flake = config;
in {
  flake.nixosConfigurations.zizenn-hack = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      (import "${inputs.home-manager}/nixos")
      ./_hardware-configuration.nix
    ] ++ flake.nixos.modules.base.imports
    ++ [{
      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs;};
        users.zizenn.imports = [
          {home = {username = "zizenn"; homeDirectory = "/home/zizenn"; stateVersion = "26.05";};}
        ] ++ flake.homeManager.modules.base.imports;
      };
      fileSystems."/" = {
        options = ["noatime" "commit=60" "data=ordered"];
      };
    }];
  };
}
