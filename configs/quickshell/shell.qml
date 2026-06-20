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

    Timer {
        interval: 3000
        running: true
        onTriggered: islandBar.showVolumeHud()
    }

    Connections {
        target: volSvc
        function onVolumeChanged() {
            islandBar.showVolumeHud()
        }
    }
}
