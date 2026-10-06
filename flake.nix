{
  description = "zizenn's nix inputs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      flake = false;
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scrolloverview = {
      # new-release tracks Hyprland git (main), which is what our hyprland
      # input follows. Pinned to PR #78 head (silicalet) until upstream merges
      # the Hyprland 0.56 workspace-presentation/render-context fixes:
      # https://github.com/yayuuu/hyprland-scroll-overview/pull/78
      # To go back to upstream: url = "github:yayuuu/hyprland-scroll-overview/new-release";
      url = "github:silicalet/hyprland-scroll-overview/d704b35e5b6028cf684506dd54b547dbfaa11a27";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs: import ./outputs.nix inputs;
}
