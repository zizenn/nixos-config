{ config, pkgs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  zenDir = ./zen-wabi;
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
    # JS bridge files
    "zen/${profile}/chrome/JS/matugen-bridge.uc.js".source =
      "${zenDir}/chrome/JS/matugen-bridge.uc.js";
    "zen/${profile}/chrome/JS/Matugen/MatugenParent.sys.mjs".source =
      "${zenDir}/chrome/JS/Matugen/MatugenParent.sys.mjs";
    "zen/${profile}/chrome/JS/Matugen/MatugenChild.sys.mjs".source =
      "${zenDir}/chrome/JS/Matugen/MatugenChild.sys.mjs";

    # fx-autoconfig utils
    "zen/${profile}/chrome/utils/boot.sys.mjs".source =
      "${zenDir}/chrome/utils/boot.sys.mjs";
    "zen/${profile}/chrome/utils/fs.sys.mjs".source =
      "${zenDir}/chrome/utils/fs.sys.mjs";
    "zen/${profile}/chrome/utils/module_loader.mjs".source =
      "${zenDir}/chrome/utils/module_loader.mjs";
    "zen/${profile}/chrome/utils/uc_api.sys.mjs".source =
      "${zenDir}/chrome/utils/uc_api.sys.mjs";
    "zen/${profile}/chrome/utils/utils.sys.mjs".source =
      "${zenDir}/chrome/utils/utils.sys.mjs";
    "zen/${profile}/chrome/utils/chrome.manifest".source =
      "${zenDir}/chrome/utils/chrome.manifest";

    # Template files (rendered by generate-matugen-vars.sh)
    "zen/templates/userChrome.css.template".source =
      "${zenDir}/templates/userChrome.css.template";
    "zen/templates/userContent.css.template".source =
      "${zenDir}/templates/userContent.css.template";
    "zen/templates/userContent.github.template".source =
      "${zenDir}/templates/userContent.github.template";
  };

  home.file.".local/bin/generate-matugen-vars" = {
    executable = true;
    source = "${zenDir}/scripts/generate-matugen-vars.sh";
  };
}
