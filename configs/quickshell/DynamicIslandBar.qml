import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import "colors.js" as Colors
import "./services" as Services
import "./modules" as Modules

PanelWindow {
    id: bar

    property string islandState: "default"

    anchors {
        top: true
        left: true
        right: true
    }

    height: {
        if (islandState === "launcher") return screen.height
        if (islandState === "expanded") return pillTargetHeight + 24
        return pillTargetHeight + 16
    }

    exclusiveZone: 0
    color: "transparent"

    property int pillHeight: 38
    property int pillDefaultWidth: 280
    property int pillExpandedWidth: 420
    property int pillLauncherWidth: 360

    property int pillTargetWidth: {
        if (islandState === "launcher") return pillLauncherWidth
        if (islandState === "expanded") return pillExpandedWidth
        return pillDefaultWidth
    }

    property int pillTargetHeight: {
        if (islandState === "launcher") return launcherContentHeight + 28
        if (islandState === "expanded") return pillHeight + 96
        return pillHeight
    }

    Services.WorkspaceService   { id: wsSvc }
    Services.AppLauncherService { id: launcherSvc }
    Services.NetworkService     { id: netSvc }
    Services.BluetoothService   { id: btSvc }

    Shortcut {
        sequence: "Alt+Space"
        onActivated: {
            if (bar.islandState === "launcher") {
                bar.islandState = "default"
                launcherSvc.query = ""
            } else {
                bar.islandState = "launcher"
            }
        }
    }

    property int launcherContentHeight: {
        var list = launcherSvc.filteredApps
        var count = list ? list.length : 0
        var rows = Math.min(count, 8)
        return 44 + rows * 38 + (rows > 0 ? 2 : 0)
    }

    Rectangle {
        id: pill

        x: (bar.width - width) / 2
        y: {
            if (bar.islandState === "launcher") return (screen.height - height) / 2 - 40
            return 8
        }

        width:  bar.pillTargetWidth
        height: bar.pillTargetHeight

        radius: bar.islandState === "launcher" ? 20 : height / 2

        color: Qt.hsla(
            Qt.color(Colors.surface).hslHue,
            Qt.color(Colors.surface).hslSaturation,
            Qt.color(Colors.surface).hslLightness,
            0.82)
        border.color: Qt.hsla(
            Qt.color(Colors.outline).hslHue,
            Qt.color(Colors.outline).hslSaturation,
            Qt.color(Colors.outline).hslLightness,
            0.12)
        border.width: 1

        layer.enabled: true

        Behavior on x      { NumberAnimation { duration: 320; easing.type: Easing.OutCubic } }
        Behavior on y      { NumberAnimation { duration: 320; easing.type: Easing.OutCubic } }
        Behavior on width  { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on height { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on radius { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on color  { ColorAnimation { duration: 200 } }

        HoverHandler {
            id: hover
            onHoveredChanged: {
                if (bar.islandState === "launcher") return
                bar.islandState = hovered ? "expanded" : "default"
            }
        }

        Item {
            id: defaultContent
            anchors.fill: parent
            visible: bar.islandState !== "launcher"
            opacity: bar.islandState !== "launcher" ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 180 } }

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
                    onSwitchRequested: function(id) { wsSvc.switchTo(id) }
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    width: 1; height: 14
                    color: Qt.hsla(
                        Qt.color(Colors.onSurface).hslHue,
                        Qt.color(Colors.onSurface).hslSaturation,
                        Qt.color(Colors.onSurface).hslLightness,
                        0.15)
                    anchors.verticalCenter: parent.verticalCenter
                }

                Modules.Clock {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                id: expandedSection
                anchors {
                    top: topRow.bottom
                    topMargin: 10
                    left: parent.left
                    right: parent.right
                    leftMargin: 16
                    rightMargin: 16
                }
                height: 64
                opacity: bar.islandState === "expanded" ? 1 : 0
                visible: opacity > 0
                Behavior on opacity { NumberAnimation { duration: 200 } }

                Rectangle {
                    id: sep
                    anchors { top: parent.top; horizontalCenter: parent.horizontalCenter }
                    width: parent.width - 12
                    height: 1
                    color: Qt.hsla(
                        Qt.color(Colors.outline).hslHue,
                        Qt.color(Colors.outline).hslSaturation,
                        Qt.color(Colors.outline).hslLightness,
                        0.08)
                }

                Row {
                    anchors {
                        top: sep.bottom
                        topMargin: 10
                        horizontalCenter: parent.horizontalCenter
                    }
                    spacing: 16

                    Modules.TrayIcons {}

                    Rectangle {
                        width: 1; height: 22
                        color: Qt.hsla(
                            Qt.color(Colors.outline).hslHue,
                            Qt.color(Colors.outline).hslSaturation,
                            Qt.color(Colors.outline).hslLightness,
                            0.1)
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Modules.StatusIcons {
                        wifiConnected: netSvc.connected
                        wifiSsid:      netSvc.ssid
                        btPowered:     btSvc.powered
                        btCount:       btSvc.connectedCount
                    }
                }
            }
        }

        Item {
            id: launcherContent
            anchors {
                fill: parent
                margins: 14
            }
            visible: bar.islandState === "launcher"
            opacity: bar.islandState === "launcher" ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 200 } }

            Modules.AppLauncher {
                width: parent.width
                launcherModel: launcherSvc
                onCloseRequested: {
                    bar.islandState = "default"
                    launcherSvc.query = ""
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        visible: bar.islandState === "launcher"
        z: -1
        onClicked: {
            bar.islandState = "default"
            launcherSvc.query = ""
        }
    }
}
