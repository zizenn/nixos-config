{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./base.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.zizenn = {
      home.username = "zizenn";
      home.homeDirectory = "/home/zizenn";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };

  fileSystems."/" = {
    options = [
      "noatime"
      "commit=60"
      "data=ordered"
    ];
  };
}
