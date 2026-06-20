{ config, pkgs, ... }:

{
  xdg.configFile = {
    "quickshell/shell.qml".source = ./quickshell/shell.qml;
    "quickshell/DynamicIslandBar.qml".source = ./quickshell/DynamicIslandBar.qml;
    "quickshell/modules/Clock.qml".source = ./quickshell/modules/Clock.qml;
    "quickshell/modules/WorkspaceDots.qml".source = ./quickshell/modules/WorkspaceDots.qml;
    "quickshell/modules/StatusIcons.qml".source = ./quickshell/modules/StatusIcons.qml;
    "quickshell/modules/TrayIcons.qml".source = ./quickshell/modules/TrayIcons.qml;

    "quickshell/services/WorkspaceService.qml".source = ./quickshell/services/WorkspaceService.qml;
    "quickshell/services/NetworkService.qml".source = ./quickshell/services/NetworkService.qml;
    "quickshell/services/BluetoothService.qml".source = ./quickshell/services/BluetoothService.qml;
    "quickshell/services/ColorService.qml".source = ./quickshell/services/ColorService.qml;
    "quickshell/services/VolumeService.qml".source = ./quickshell/services/VolumeService.qml;
  };

  home.packages = with pkgs; [
    quickshell
  ];
}
