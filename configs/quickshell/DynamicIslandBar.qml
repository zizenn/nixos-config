import QtQuick
import Quickshell

import "./services" as Services
import "./modules" as Modules

PanelWindow {
    id: bar

    property string islandState: "default"
    property var colors: null

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
}
