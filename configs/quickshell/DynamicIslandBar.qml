import QtQuick
import QtQuick.Window
import Quickshell
import Quickshell.Io

import "./services" as Services
import "./modules" as Modules

PanelWindow {
    id: bar

    mask: Region { item: pill }

    property string islandState: "default"
    property var colors: null
    property var volSvc: null
    property string activeSelector: "none"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: pill.y + pill.height + 4

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
        interval: 80
        onTriggered: showExpanded = true
    }

    // Click-outside catcher
    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: {
            if (activeSelector !== "none")
                activeSelector = "none"
        }
    }

    Rectangle {
        id: pill

        x: (bar.width - width) / 2
        y: 8
        width: {
            if (activeSelector === "none") {
                var top = topRow.implicitWidth + pillPadding * 2
                var exp = islandState === "expanded" ? contentRow.implicitWidth + 32 + pillPadding * 2 : 0
                return Math.max(top, exp)
            }
            if (activeSelector === "wifi")
                return Math.max(280, wifiBody.implicitWidth + pillPadding * 2)
            if (activeSelector === "bluetooth")
                return Math.max(280, btBody.implicitWidth + pillPadding * 2)
            if (activeSelector === "power")
                return 440
            return pillPadding * 2
        }
        height: {
            if (activeSelector === "wifi")
                return pillHeight + wifiBody.implicitHeight + 16
            if (activeSelector === "bluetooth")
                return pillHeight + btBody.implicitHeight + 16
            if (activeSelector === "power")
                return pillHeight + powerBody.y + powerBody.implicitHeight + 8
            if (activeSelector !== "none")
                return pillHeight + powerBody.implicitHeight + 16
            var h = pillHeight
            if (islandState === "expanded")
                h += expandedSection.height
            return h
        }
        radius: islandState === "expanded" || activeSelector !== "none" ? 12 : 20

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
                if (activeSelector === "none")
                    bar.islandState = hovered ? "expanded" : "default"
            }
        }

        // ── Normal mode ──
        Row {
            id: topRow
            anchors.horizontalCenter: parent.horizontalCenter
            y: (pillHeight - implicitHeight) / 2
            spacing: 18
            visible: activeSelector === "none"

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
            visible: activeSelector === "none"

            // No height behavior — pill's own height animation handles the grow
            Behavior on opacity { NumberAnimation { duration: 200 } }

            Row {
                id: contentRow
                anchors { top: parent.top; topMargin: 8; horizontalCenter: parent.horizontalCenter }
                spacing: 16
                opacity: showExpanded ? 1 : 0

                Behavior on opacity { NumberAnimation { duration: 150 } }

                Modules.TrayIcons { parentWindow: bar }

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
                    onPowerClicked: activeSelector = activeSelector === "power" ? "none" : "power"
                }
            }
        }

        // ── Wifi selector mode ──
        Column {
            id: wifiBody
            x: pillPadding
            y: 8
            width: parent.width - pillPadding * 2
            spacing: 8
            visible: activeSelector === "wifi"

            Row {
                spacing: 8
                width: parent.width

                Text {
                    text: "\u2190"
                    color: colors.cOnSurface
                    font.pixelSize: 14
                    font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: activeSelector = "none"
                    }
                }

                Text {
                    text: "Wi-Fi"
                    color: colors.cOnSurface
                    font.pixelSize: 13
                    font.weight: Font.Medium
                    font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: 1; height: 1 }

                Text {
                    text: "\uf021"
                    color: colors.cOnSurface
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11
                    opacity: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: { if (netSvc) netSvc.scan() }
                    }
                }
            }

            Rectangle {
                height: 1; width: parent.width
                color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.1)
            }

            Row {
                spacing: 8

                Text {
                    text: netSvc && netSvc.enabled ? "On" : "Off"
                    color: netSvc && netSvc.enabled ? colors.primary : Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.4)
                    font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    width: 36; height: 18; radius: 9
                    color: netSvc && netSvc.enabled ? colors.primary : Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.2)
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        x: netSvc && netSvc.enabled ? 20 : 2; y: 2; width: 14; height: 14; radius: 7; color: "#ffffff"
                        Behavior on x { NumberAnimation { duration: 100 } }
                    }

                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { if (netSvc) netSvc.setEnabled(!netSvc.enabled) }
                    }
                }
            }

            Column {
                id: wifiList
                width: parent.width
                spacing: 2
                visible: netSvc && netSvc.enabled

                Text {
                    text: "Available Networks"
                    color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.5)
                    font.pixelSize: 10; font.family: "JetBrainsMono Nerd Font"
                    visible: netSvc && netSvc.availableNetworks && netSvc.availableNetworks.length > 0
                }

                Repeater {
                    model: netSvc ? netSvc.availableNetworks : []

                    Rectangle {
                        required property var modelData
                        width: wifiList.width
                        height: 28; radius: 6
                        color: mouseArea.containsMouse ? Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.08) : "transparent"

                        Row {
                            x: 8; spacing: 8; anchors.verticalCenter: parent.verticalCenter
                            Text {
                                text: {
                                    var s = modelData.ssid
                                    if (s === netSvc.ssid && netSvc.connected) return "\u2713 " + s
                                    return s
                                }
                                color: modelData.ssid === netSvc.ssid && netSvc.connected ? colors.primary : colors.cOnSurface
                                font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight; maximumLineCount: 1; width: 140
                            }
                            Text {
                                text: {
                                    var sig = modelData.signal
                                    if (sig >= 75) return "\u2588\u2588\u2588\u2588"
                                    if (sig >= 50) return "\u2588\u2588\u2588\u2582"
                                    if (sig >= 25) return "\u2588\u2588\u2582\u2581"
                                    return "\u2588\u2582\u2581\u2581"
                                }
                                color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.6)
                                font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: modelData.security && modelData.security !== "--" ? "\uD83D\uDD12" : ""
                                font.pixelSize: 10; anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { if (netSvc) netSvc.connectToNetwork(modelData.ssid) }
                        }
                    }
                }
            }
        }

        // ── Bluetooth selector mode ──
        Column {
            id: btBody
            x: pillPadding
            y: 8
            width: parent.width - pillPadding * 2
            spacing: 8
            visible: activeSelector === "bluetooth"

            Row {
                spacing: 8; width: parent.width

                Text {
                    text: "\u2190"
                    color: colors.cOnSurface
                    font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: activeSelector = "none"
                    }
                }

                Text {
                    text: "Bluetooth"
                    color: colors.cOnSurface
                    font.pixelSize: 13; font.weight: Font.Medium; font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: 1; height: 1 }

                Text {
                    text: btSvc && btSvc.discovering ? "\uf28e" : "\uf021"
                    color: colors.cOnSurface
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11; opacity: 0.5
                    anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (!btSvc) return
                            btSvc.discovering ? btSvc.stopDiscovery() : btSvc.startDiscovery()
                        }
                    }
                }
            }

            Rectangle {
                height: 1; width: parent.width
                color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.1)
            }

            Row {
                spacing: 8

                Text {
                    text: btSvc && btSvc.powered ? "On" : "Off"
                    color: btSvc && btSvc.powered ? colors.primary : Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.4)
                    font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    width: 36; height: 18; radius: 9
                    color: btSvc && btSvc.powered ? colors.primary : Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.2)
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle {
                        x: btSvc && btSvc.powered ? 20 : 2; y: 2; width: 14; height: 14; radius: 7; color: "#ffffff"
                        Behavior on x { NumberAnimation { duration: 100 } }
                    }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { if (btSvc) btSvc.setEnabled(!btSvc.powered) }
                    }
                }
            }

            Column {
                id: btList
                width: parent.width; spacing: 2
                visible: btSvc && btSvc.powered

                Text {
                    text: "Devices"
                    color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.5)
                    font.pixelSize: 10; font.family: "JetBrainsMono Nerd Font"
                    visible: btSvc && btSvc.availableDevices && btSvc.availableDevices.length > 0
                }

                Repeater {
                    model: btSvc ? btSvc.availableDevices : []

                    Rectangle {
                        required property var modelData
                        width: btList.width; height: 28; radius: 6
                        color: mouseArea.containsMouse ? Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.08) : "transparent"

                        Row {
                            x: 8; spacing: 8; anchors.verticalCenter: parent.verticalCenter
                            Text {
                                text: {
                                    var d = modelData
                                    if (d.connected) return "\u2713 " + d.name
                                    return d.name || d.address
                                }
                                color: modelData.connected ? colors.primary : colors.cOnSurface
                                font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                                elide: Text.ElideRight; maximumLineCount: 1; width: 150
                            }
                            Text {
                                text: modelData.connected ? "Connected" : ""
                                color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.5)
                                font.pixelSize: 10; font.family: "JetBrainsMono Nerd Font"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (!btSvc) return
                                modelData.connected ? btSvc.disconnectDevice(modelData.address) : btSvc.connectToDevice(modelData.address)
                            }
                        }
                    }
                }

                Text {
                    text: btSvc && btSvc.discovering ? "Discovering..." : ""
                    color: Qt.hsla(Qt.color(colors.cOnSurface).hslHue, Qt.color(colors.cOnSurface).hslSaturation, Qt.color(colors.cOnSurface).hslLightness, 0.4)
                    font.pixelSize: 10; font.family: "JetBrainsMono Nerd Font"; font.italic: true
                    visible: btSvc && btSvc.discovering
                }
            }
        }
    }

    // ── Power menu mode ──
    Column {
        id: powerBody
        y: 6
        width: parent.width
        spacing: 8
        visible: activeSelector === "power"

        Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "\u2190"
                color: colors.cOnSurface
                font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                    onClicked: activeSelector = "none"
                }
            }

            Text {
                text: "Power"
                color: colors.cOnSurface
                font.pixelSize: 13; font.weight: Font.Medium; font.family: "JetBrainsMono Nerd Font"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Repeater {
                model: [
                    { icon: "\uf023",  label: "Lock",     accent: false, cmd: "loginctl lock-session" },
                    { icon: "\uf2f5",  label: "Log Out",  accent: false, cmd: "hyprctl dispatch exit" },
                    { icon: "\uf186",  label: "Suspend",  accent: false, cmd: "systemctl suspend" },
                    { icon: "\uf021",  label: "Reboot",   accent: true,  cmd: "systemctl reboot" },
                    { icon: "\uf011",  label: "Shut Down", accent: true,  cmd: "systemctl poweroff" },
                ]

                Rectangle {
                    required property var modelData
                    width: 70; height: 70; radius: 14
                    color: mouseArea.containsMouse
                        ? Qt.hsla(Qt.color(colors.surface).hslHue, Qt.color(colors.surface).hslSaturation, Qt.color(colors.surface).hslLightness, 0.95)
                        : Qt.hsla(Qt.color(colors.surface).hslHue, Qt.color(colors.surface).hslSaturation, Qt.color(colors.surface).hslLightness, 0.85)

                    Behavior on color { ColorAnimation { duration: 100 } }

                    Column {
                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            text: modelData.icon
                            color: modelData.accent ? colors.primary : colors.cOnSurface
                            font.family: "JetBrainsMono Nerd Font"
                            font.pixelSize: 22
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: modelData.label
                            color: modelData.accent ? colors.primary : colors.cOnSurface
                            font.pixelSize: 10
                            font.family: "JetBrainsMono Nerd Font"
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            activeSelector = "none"
                            Qt.createQmlObject(
                                'import Quickshell.Io; Process { command: ["bash", "-c", ' + JSON.stringify(modelData.cmd) + ']; running: true }',
                                bar)
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: volumeHud
        anchors.right: parent.right
        anchors.rightMargin: 24
        y: (Screen.height - height) / 2
        width: hudColumn.implicitWidth + 32
        height: hudColumn.implicitHeight + 32
        radius: 16
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

        Column {
            id: hudColumn
            anchors.centerIn: parent
            spacing: 12

            Text {
                text: volSvc ? (volSvc.muted ? "\uf6a9" : "\uf028") : "\uf028"
                color: colors.cOnSurface
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 22
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: track
                width: 6
                height: 100
                radius: 3
                color: Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.15)
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: parent.width
                    height: track.height * (volSvc ? volSvc.volume : 0)
                    radius: 3
                    color: volSvc && volSvc.muted
                        ? colors.cOnSurface
                        : colors.primary
                    anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter }

                    Behavior on height { NumberAnimation { duration: 80 } }
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
                font.pixelSize: 13
                font.family: "JetBrainsMono Nerd Font"
                anchors.horizontalCenter: parent.horizontalCenter
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
