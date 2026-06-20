import QtQuick
import Quickshell

import "./services" as Services
import "./modules" as Modules

PanelWindow {
    id: bar

    property string islandState: "default"
    property var colors: null
    property var volSvc: null
    property string activeSelector: "none"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: {
        var base = pill.y + pill.height + 4
        var hudBottom = pill.y + pill.height + 12 + volumeHud.height
        var selBottom = pill.y + pill.height + 12 + Math.max(wifiSelector.height, btSelector.height)
        return Math.max(base, hudBottom, selBottom)
    }

    exclusiveZone: 0
    color: "transparent"

    property int pillHeight: 38
    property int pillPadding: 24
    property bool showExpanded: false

    Services.WorkspaceService { id: wsSvc }
    Services.NetworkService   { id: netSvc }
    Services.BluetoothService { id: btSvc }

    onActiveSelectorChanged: {
        if (activeSelector !== "none")
            islandState = "expanded"
    }

    onIslandStateChanged: {
        if (islandState === "expanded") {
            expandDelay.restart()
        } else {
            expandDelay.stop()
            showExpanded = false
        }
    }

    Timer {
        id: expandDelay
        interval: 100
        onTriggered: showExpanded = true
    }

    Item {
        id: pill

        x: (bar.width - width) / 2
        y: 0

        width: {
            var top = topRow.implicitWidth + pillPadding * 2
            var exp = contentRow.implicitWidth + 32 + pillPadding * 2
            return Math.max(top, exp)
        }
        height: {
            var h = pillHeight
            if (islandState === "expanded")
                h += expandedSection.height
            return h
        }

        Behavior on width  { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on height { NumberAnimation { duration: 260; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

        HoverHandler {
            id: hover
            onHoveredChanged: {
                if (activeSelector === "none")
                    bar.islandState = hovered ? "expanded" : "default"
            }
        }

        Canvas {
            id: notchCanvas
            anchors.fill: parent

            property color topColor: "#000000"
            property color bottomColor: colors ? Qt.hsla(
                Qt.color(colors.surface).hslHue,
                Qt.color(colors.surface).hslSaturation,
                Qt.color(colors.surface).hslLightness,
                0.82) : "#1e1e2e"
            property color borderColor: colors ? Qt.hsla(
                Qt.color(colors.outline).hslHue,
                Qt.color(colors.outline).hslSaturation,
                Qt.color(colors.outline).hslLightness,
                0.12) : "transparent"

            onBottomColorChanged: requestPaint()
            onBorderColorChanged: requestPaint()
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()

            onPaint: {
                var ctx = getContext("2d")
                var w = width
                var h = height
                var r = 10
                var flare = 14

                ctx.clearRect(0, 0, w, h)

                var grad = ctx.createLinearGradient(0, 0, 0, h)
                grad.addColorStop(0.0, topColor)
                grad.addColorStop(0.4, bottomColor)

                ctx.beginPath()
                ctx.moveTo(w / 2, 0)
                ctx.quadraticCurveTo(0, flare, 0, flare * 2)
                ctx.lineTo(0, h - r)
                ctx.quadraticCurveTo(0, h, r, h)
                ctx.lineTo(w - r, h)
                ctx.quadraticCurveTo(w, h, w, h - r)
                ctx.lineTo(w, flare * 2)
                ctx.quadraticCurveTo(w, flare, w / 2, 0)
                ctx.closePath()
                ctx.fillStyle = grad
                ctx.fill()

                if (colors) {
                    ctx.beginPath()
                    ctx.moveTo(w / 2, 0)
                    ctx.quadraticCurveTo(0, flare, 0, flare * 2)
                    ctx.lineTo(0, h - r)
                    ctx.quadraticCurveTo(0, h, r, h)
                    ctx.lineTo(w - r, h)
                    ctx.quadraticCurveTo(w, h, w, h - r)
                    ctx.lineTo(w, flare * 2)
                    ctx.quadraticCurveTo(w, flare, w / 2, 0)
                    ctx.closePath()
                    ctx.strokeStyle = borderColor
                    ctx.lineWidth = 1
                    ctx.stroke()
                }
            }
        }

        Row {
            id: topRow
            x: pillPadding
            y: (pillHeight - implicitHeight) / 2
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
            width: parent.width
            height: islandState === "expanded" ? contentRow.height + 14 : 0
            anchors { top: topRow.bottom; topMargin: 0 }
            clip: true
            opacity: islandState === "expanded" ? 1 : 0

            Behavior on height { NumberAnimation { duration: 200 } }
            Behavior on opacity { NumberAnimation { duration: 200 } }

            Row {
                id: contentRow
                anchors { top: parent.top; topMargin: 8; horizontalCenter: parent.horizontalCenter }
                spacing: 16
                opacity: showExpanded ? 1 : 0

                Behavior on opacity { NumberAnimation { duration: 150 } }

                Modules.TrayIcons {}

                Modules.StatusIcons {
                    wifiConnected: netSvc.connected
                    wifiSsid:      netSvc.ssid
                    btPowered:     btSvc.powered
                    btCount:       btSvc.connectedCount
                    colors: bar.colors
                    onWifiClicked: {
                        activeSelector = activeSelector === "wifi" ? "none" : "wifi"
                        if (activeSelector === "wifi") netSvc.scan()
                    }
                    onBtClicked: {
                        activeSelector = activeSelector === "bluetooth" ? "none" : "bluetooth"
                        if (activeSelector === "bluetooth") btSvc.refreshDevices()
                    }
                }
            }
        }
    }

    Modules.WifiSelector {
        id: wifiSelector
        x: (bar.width - width) / 2
        y: pill.y + pill.height + 12
        colors: bar.colors
        netSvc: netSvc
        wifiSsid: netSvc.ssid
        wifiConnected: netSvc.connected
        visible: activeSelector === "wifi"
        opacity: visible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 120 } }
    }

    Modules.BluetoothSelector {
        id: btSelector
        x: (bar.width - width) / 2
        y: pill.y + pill.height + 12
        colors: bar.colors
        btSvc: btSvc
        visible: activeSelector === "bluetooth"
        opacity: visible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 120 } }
    }

    Rectangle {
        id: volumeHud
        x: (bar.width - width) / 2
        y: pill.y + pill.height + 12
        width: hudRow.implicitWidth + 24
        height: hudRow.implicitHeight + 20
        radius: 14
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
        z: 10

        Behavior on opacity { NumberAnimation { duration: 120 } }

        Row {
            id: hudRow
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
