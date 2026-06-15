{
  description = "My NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # for default nixpkgs
    zen-browser.url = "github:youwen5/zen-browser-flake"; # for zen browser
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # Change 'nix-port' to your actual hostname (run 'hostname' in terminal to check)
      nix-port = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
