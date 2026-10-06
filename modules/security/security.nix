{ ... }: {
  nixos.modules.base = {
    security.doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    security.sudo.enable = false;
    nixpkgs.config.allowUnfree = true;
    security.polkit.enable = true;
    # Provides setuid /run/wrappers/bin/pkexec (polkit's bin output alone
    # is NOT setuid, so pkexec fails with "must be setuid root" without this).
    # Auth dialogs are handled by Noctalia's built-in polkit agent
    # (polkit_agent = true) — do not add hyprpolkitagent / lxqt-policykit, etc.
    security.polkit.enablePkexecWrapper = true;
  };
}
