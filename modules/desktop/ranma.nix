{ pkgs, inputs, ... }: {
  # Elephant is ranma's launcher backend.
  services.elephant.enable = true;

  environment.systemPackages = with pkgs; [
    (rustPlatform.buildRustPackage {
      pname = "ranma";
      version = "unstable";

      src = inputs.ranma;

      cargoLock.lockFile = "${inputs.ranma}/Cargo.lock";
      nativeBuildInputs = [ pkg-config ];
      nativeCheckInputs = [ git ];
      buildInputs = [ lua ];
    })
  ];
}
