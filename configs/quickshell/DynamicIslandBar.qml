import QtQuick
import Quickshell

import "./services" as Services
import "./modules" as Modules

PanelWindow {
    id: bar

    property string islandState: "default"
    property var colors: null
    property var volSvc: null

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: {
        if (islandState === "expanded") return pillTargetHeight + 24
        return pillTargetHeight + 16
    }

    exclusiveZone: 0
    color: "transparent"

    property int pillHeight: 38
    property int pillDefaultWidth: 280
    property int pillExpandedWidth: 420

    property int pillTargetWidth: {
        if (islandState === "expanded") return pillExpandedWidth
        return pillDefaultWidth
    }

    property int pillTargetHeight: {
        if (islandState === "expanded") return pillHeight + 8 + expandedSection.height
        return pillHeight
    }

    Services.WorkspaceService { id: wsSvc }
    Services.NetworkService   { id: netSvc }
    Services.BluetoothService { id: btSvc }

    Rectangle {
        id: pill

        x: (bar.width - width) / 2
        y: 8

        width:  bar.pillTargetWidth
        height: bar.pillTargetHeight

        radius: height / 2

        color: Qt.hsla(
            Qt.color(colors.surface).hslHue,
            Qt.color(colors.surface).hslSaturation,
            Qt.color(colors.surface).hslLightness,
            0.82)
        border.color: Qt.hsla(
            Qt.color(colors.outline).hslHue,
            Qt.color(colors.outline).hslSaturation,
            Qt.color(colors.outline).hslLightness,
            0.12)
        border.width: 1

        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
        Behavior on width  { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on height { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on color  { ColorAnimation { duration: 200 } }

        HoverHandler {
            id: hover
            onHoveredChanged: {
                bar.islandState = hovered ? "expanded" : "default"
            }
        }

        Row {
            id: topRow
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: (bar.pillHeight - implicitHeight) / 2
            }
            spacing: 18

            Modules.WorkspaceDots {
                id: wsDots
                workspaces: wsSvc.workspaces
                activeId:   wsSvc.activeId
                colors: bar.colors
                onSwitchRequested: function(id) { wsSvc.switchTo(id) }
                anchors.verticalCenter: parent.verticalCenter
            }

            Modules.Clock {
                anchors.verticalCenter: parent.verticalCenter
                colors: bar.colors
            }
        }

        Item {
            id: expandedSection
            anchors {
                top: topRow.bottom
                left: parent.left
                right: parent.right
                leftMargin: 16
                rightMargin: 16
            }
            height: contentRow.height + 18
            opacity: bar.islandState === "expanded" ? 1 : 0
            visible: opacity > 0
            Behavior on opacity { NumberAnimation { duration: 200 } }

            Row {
                id: contentRow
                anchors {
                    top: parent.top
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 16

                Modules.TrayIcons {}

                Modules.StatusIcons {
                    wifiConnected: netSvc.connected
                    wifiSsid:      netSvc.ssid
                    btPowered:     btSvc.powered
                    btCount:       btSvc.connectedCount
                    colors: bar.colors
                }
            }
        }
    }

    Rectangle {
        id: volumeHud
        x: (bar.width - width) / 2
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
        visible: true
        opacity: 0
        z: 100

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
            onTriggered: volumeHud.opacity = 0
        }

        function show() {
            opacity = 1
            hideTimer.restart()
        }
    }

    function showVolumeHud() {
        volumeHud.show()
    }
}

