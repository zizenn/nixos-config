# Copy to your C/C++ project's root as devenv.nix, then `devenv shell`
# (or `devenv allow` once — the fish hook auto-activates on cd).
# Open nvim from inside the shell and clangd / clang-format / lldb-dap
# resolve from this shell's PATH. Run :TSUpdate once from here too —
# parsers compile with this shell's cc and persist in ~/.local/share/nvim.
{ pkgs, ... }:
{
  languages.c.enable = true;
  languages.cplusplus = {
    enable = true;
    lsp.enable = false; # nvim uses clangd from clang-tools below, not ccls
  };

  packages = with pkgs; [
    clang-tools # clangd + clang-format
    lldb # provides lldb-dap for nvim-dap
    gdb
    gnumake
    tree-sitter
  ];
}
