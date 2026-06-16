{
  description = "my nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # for default nixpkgs
    zen-browser.url = "github:youwen5/zen-browser-flake"; # for zen browser
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1"; # for secure boot
    home-manager.url = "github:nix-community/home-manager"; # home manager
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nix-port = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
