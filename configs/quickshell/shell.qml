import Quickshell
import QtQuick
import "./services" as Services

ShellRoot {
    Services.ColorService   { id: colors }
    Services.VolumeService  { id: volSvc }

    DynamicIslandBar {
        colors: colors
        volSvc: volSvc
    }

    Connections {
        target: volSvc
        function onVolumeChanged() {
            bar.showVolumeHud()
        }
    }
}
