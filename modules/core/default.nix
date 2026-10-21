{ ... }: {
  imports = [
    ./boot.nix
    ./system.nix
    ./networking.nix
    ./nix.nix
    ./nix-ld.nix
    ./security.nix
    ./services.nix
  ];
}
