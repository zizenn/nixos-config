# Copy to your Rust project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Copy the sibling rustfmt.toml next to Cargo.toml for 6-space formatting.
# Open nvim from inside the shell and lspconfig's rust_analyzer
# picks up this rust-analyzer from PATH.
{ pkgs, ... }:
{
  languages.rust.enable = true;

  packages = with pkgs; [
    rust-analyzer # also bundled by languages.rust; listed so it's grep-able
  ];
}
