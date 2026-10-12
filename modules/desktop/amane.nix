{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.amane.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
