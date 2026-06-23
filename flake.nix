{
  description = "my nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    waylandar = {
      url = "github:samjoshuadud/waylandar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-config = {
      url = "path:./configs/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, waylandar, neovim-config, ... }@inputs: {
    nixosConfigurations = {
      nix-port = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };

    # This block enables "nh home switch" to work
    homeConfigurations = {
      "zizenn@nix-port" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
          {
            home.username = "zizenn";
            home.homeDirectory = "/home/zizenn";
            home.stateVersion = "26.05"; 
          }
        ];
      };
    };

    # Expose neovim-config packages directly in this flake
    packages = neovim-config.packages;
  };
}
