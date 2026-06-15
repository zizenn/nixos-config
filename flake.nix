{
  description = "My NixOS Flake Configuration";

  inputs = {
    # Use the unstable or stable nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
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
