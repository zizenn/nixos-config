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
        volumeHud: hudPill
    }

    PanelWindow {
        id: hudWin
        anchors { top: true; left: true; right: true }
        exclusiveZone: 0
        color: "transparent"
        height: 120

        Rectangle {
            id: hudPill
            x: (hudWin.width - width) / 2
            y: 56
            width: 180
            height: 40
            radius: height / 2
            color: Qt.hsla(
                Qt.color(colors.surface).hslHue,
                Qt.color(colors.surface).hslSaturation,
                Qt.color(colors.surface).hslLightness,
                0.88)
            border.color: Qt.hsla(
                Qt.color(colors.outline).hslHue,
                Qt.color(colors.outline).hslSaturation,
                Qt.color(colors.outline).hslLightness,
                0.12)
            border.width: 1
            opacity: 0

            Behavior on opacity { NumberAnimation { duration: 120 } }

            Row {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 12 }
                spacing: 8

                Text {
                    text: volSvc ? (volSvc.muted ? "\uf6a9" : "\uf028") : "\uf028"
                    color: colors.cOnSurface
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    id: track
                    width: 90
                    height: 4
                    radius: 2
                    color: Qt.hsla(
                        Qt.color(colors.cOnSurface).hslHue,
                        Qt.color(colors.cOnSurface).hslSaturation,
                        Qt.color(colors.cOnSurface).hslLightness,
                        0.15)
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: track.width * (volSvc ? volSvc.volume : 0)
                        height: parent.height
                        radius: 2
                        color: volSvc && volSvc.muted
                            ? colors.cOnSurface
                            : colors.primary
                        anchors { left: parent.left; verticalCenter: parent.verticalCenter }

                        Behavior on width { NumberAnimation { duration: 80 } }
                        Behavior on color { ColorAnimation { duration: 80 } }
                    }
                }

                Text {
                    text: volSvc ? Math.round(volSvc.volume * 100) + "%" : "0%"
                    color: Qt.hsla(
                        Qt.color(colors.cOnSurface).hslHue,
                        Qt.color(colors.cOnSurface).hslSaturation,
                        Qt.color(colors.cOnSurface).hslLightness,
                        0.7)
                    font.pixelSize: 11
                    font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            property Timer hideTimer: Timer {
                interval: 1500
                running: false
                onTriggered: hudPill.opacity = 0
            }

            function show() {
                opacity = 1
                hideTimer.restart()
            }
        }
    }

    Connections {
        target: volSvc
        function onVolumeChanged() {
            islandBar.showVolumeHud()
        }
    }
}
