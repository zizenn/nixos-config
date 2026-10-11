{ pkgs, inputs, ... }: {
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
