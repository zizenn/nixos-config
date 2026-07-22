{ config, lib, pkgs, inputs, ... }: {
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.zizenn = {
      imports = [
        ../home/default.nix
      ];

      home = {
        username = "zizenn";
        homeDirectory = "/home/zizenn";
        stateVersion = "26.05";
      };
    };
  };
}
