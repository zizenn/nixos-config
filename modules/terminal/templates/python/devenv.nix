# Copy to your Python project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Open nvim from inside the shell and pyright / ruff / autopep8
# resolve from this shell's PATH.
{ pkgs, ... }:
{
  languages.python.enable = true;

  packages = with pkgs; [
    pyright
    ruff
    python3Packages.autopep8
    python3Packages.debugpy
  ];
}
