# Copy to your web project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Open nvim from inside the shell and ts_ls / html / cssls /
# prettier / eslint_d resolve from this shell's PATH.
{ pkgs, ... }:
{
  languages.javascript.enable = true;

  packages = with pkgs; [
    typescript-language-server
    vscode-langservers-extracted # html, css, json language servers
    prettier
    eslint_d
  ];
}
