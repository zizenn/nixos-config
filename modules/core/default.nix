{ ... }: {
  imports = [
    ./boot.nix
    ./system.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./services.nix
  ];
}
