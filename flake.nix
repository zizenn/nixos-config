{
  description = "zizenn's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wlctl.url = "github:aashish-thapa/wlctl";
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations.nix-port = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./modules/system/configuration.nix ];
      };

      homeConfigurations."zizenn@nix-port" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./modules/home/default.nix
          {
            home.username = "zizenn";
            home.homeDirectory = "/home/zizenn";
            home.stateVersion = "26.05";
          }
        ];
      };
    };
}
