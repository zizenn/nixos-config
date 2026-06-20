//@ pragma UseQApplication
import Quickshell
import QtQuick
import "./services" as Services

ShellRoot {
    Services.ColorService   { id: colors }
    Services.VolumeService  { id: volSvc }

    DynamicIslandBar {
        id: islandBar
        colors: colors
        volSvc: volSvc
    }

    Connections {
        target: volSvc
        function onVolumeChanged() {
            islandBar.showVolumeHud()
        }
    }
}
