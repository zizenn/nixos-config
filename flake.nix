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
    areofyl-fetch.url = "github:areofyl/fetch";
    herdr.url = "github:ogulcancelik/herdr";
    wlctl.url = "github:aashish-thapa/wlctl";
    zsh-transient-prompt = {
      url = "github:olets/zsh-transient-prompt";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, zsh-transient-prompt, ... }@inputs: {
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
