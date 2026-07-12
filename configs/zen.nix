{ config, pkgs, ... }:

let
  base = ./zen-wabi;
  profile = "632wsxku.Default Profile";
in
{
  home.file."${profile}/user.js" = {
    force = true;
    text = ''
      // fx-autoconfig for zen-wabi (matugen bridge)
      user_pref("userChromeJS.experimental.enabled", true);
      user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      user_pref("zen.boosts.enabled", true);

      // DevTools for debugging
      user_pref("devtools.chrome.enabled", true);
      user_pref("devtools.debugger.remote-enabled", true);
    '';
  };

  xdg.configFile = {
    "zen/${profile}/chrome/JS/matugen-bridge.uc.js".source =
      base + "/chrome/JS/matugen-bridge.uc.js";
    "zen/${profile}/chrome/JS/Matugen/MatugenParent.sys.mjs".source =
      base + "/chrome/JS/Matugen/MatugenParent.sys.mjs";
    "zen/${profile}/chrome/JS/Matugen/MatugenChild.sys.mjs".source =
      base + "/chrome/JS/Matugen/MatugenChild.sys.mjs";
    "zen/${profile}/chrome/utils/boot.sys.mjs".source =
      base + "/chrome/utils/boot.sys.mjs";
    "zen/${profile}/chrome/utils/fs.sys.mjs".source =
      base + "/chrome/utils/fs.sys.mjs";
    "zen/${profile}/chrome/utils/module_loader.mjs".source =
      base + "/chrome/utils/module_loader.mjs";
    "zen/${profile}/chrome/utils/uc_api.sys.mjs".source =
      base + "/chrome/utils/uc_api.sys.mjs";
    "zen/${profile}/chrome/utils/utils.sys.mjs".source =
      base + "/chrome/utils/utils.sys.mjs";
    "zen/${profile}/chrome/utils/chrome.manifest".source =
      base + "/chrome/utils/chrome.manifest";
    "zen/templates/userChrome.css.template".source =
      base + "/templates/userChrome.css.template";
    "zen/templates/userContent.css.template".source =
      base + "/templates/userContent.css.template";
    "zen/templates/userContent.github.template".source =
      base + "/templates/userContent.github.template";
  };

  home.file.".local/bin/generate-matugen-vars" = {
    executable = true;
    source = base + "/scripts/generate-matugen-vars.sh";
  };
}
