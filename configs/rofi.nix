{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."rofi/config.rasi" = {
    force = true;
    source = pkgs.writeText "rofi-config.rasi" ''
      /* ───────────────────────────────────────────────────────────────────
         「✦ ROFI CONFIG ✦ 」
         ──────────────────────────────────────────────────────────────── */

      /* ── CONFIGURATION ────────────────────────────────────────────────*/
      configuration {
          modi: "drun";
          show-icons: true;
          sidebar-mode: false;

          display-drun: "";
      }

      /* ── THEME ────────────────────────────────────────────────────────*/
      @theme "~/.config/rofi/themes/glass.rasi"
    '';
  };
}
