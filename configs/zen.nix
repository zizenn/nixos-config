{ config, pkgs, ... }:

let
  profilePath = "632wsxku.Default Profile";
in
{
  # ============================================================
  # ZEN USER.JS — browser preferences
  # ============================================================
  xdg.configFile."zen/${profilePath}/user.js".text = ''
    // Enable legacy user profile customizations (userChrome.css / userContent.css)
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    // Disable upgrade dialog
    user_pref("browser.startup.upgradeDialog.enabled", false);
    // Disable auto-play
    user_pref("media.autoplay.default", 5);
    // Enable DRM
    user_pref("media.eme.enabled", true);
  '';

  # ============================================================
  # ZEN CHROME DIRECTORY — links to matugen-rendered CSS
  # ============================================================
  home.file = {
    ".config/zen/${profilePath}/chrome/userChrome.css".text = ''
      @import url("matugen-chrome.css");
    '';
    ".config/zen/${profilePath}/chrome/userContent.css".text = ''
      @import url("matugen-content.css");
    '';
  };
}
