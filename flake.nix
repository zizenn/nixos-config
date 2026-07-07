{
  description = "zizenn's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    areofyl-fetch.url = "github:areofyl/fetch";
    herdr.url = "github:ogulcancelik/herdr";
    wlctl.url = "github:aashish-thapa/wlctl";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nix-port = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };

    homeConfigurations."zizenn@nix-port" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home.nix
        inputs.areofyl-fetch.homeManagerModules.default
        {
          home.username = "zizenn";
          home.homeDirectory = "/home/zizenn";
          home.stateVersion = "26.05";
        }
      ];
    };
  };
}
