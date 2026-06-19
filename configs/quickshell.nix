{ config, pkgs, ... }:

{
  xdg.configFile = {
    "quickshell/shell.qml".source = ./quickshell/shell.qml;
    "quickshell/colors.js".source = ./quickshell/colors.js;
    "quickshell/DynamicIslandBar.qml".source = ./quickshell/DynamicIslandBar.qml;

    "quickshell/modules/Clock.qml".source = ./quickshell/modules/Clock.qml;
    "quickshell/modules/WorkspaceDots.qml".source = ./quickshell/modules/WorkspaceDots.qml;
    "quickshell/modules/StatusIcons.qml".source = ./quickshell/modules/StatusIcons.qml;
    "quickshell/modules/TrayIcons.qml".source = ./quickshell/modules/TrayIcons.qml;
    "quickshell/modules/AppLauncher.qml".source = ./quickshell/modules/AppLauncher.qml;

    "quickshell/services/WorkspaceService.qml".source = ./quickshell/services/WorkspaceService.qml;
    "quickshell/services/AppLauncherService.qml".source = ./quickshell/services/AppLauncherService.qml;
    "quickshell/services/NetworkService.qml".source = ./quickshell/services/NetworkService.qml;
    "quickshell/services/BluetoothService.qml".source = ./quickshell/services/BluetoothService.qml;
  };

  home.packages = with pkgs; [
    quickshell
  ];
}
