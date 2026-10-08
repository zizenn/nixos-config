# Copy to your Nix project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Open nvim from inside the shell and nixd / nixfmt
# resolve from this shell's PATH.
{ pkgs, ... }:
{
  languages.nix.enable = true;

  packages = with pkgs; [
    nixd
    nixfmt
  ];
}
