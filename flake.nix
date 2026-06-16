{
  description = "my nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # for default nixpkgs
    zen-browser.url = "github:youwen5/zen-browser-flake"; # for zen browser
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1"; # for secure boot
    <home-manager/nixos> # home manager
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Change 'nix-port' to your actual hostname (run 'hostname' in terminal to check)
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
