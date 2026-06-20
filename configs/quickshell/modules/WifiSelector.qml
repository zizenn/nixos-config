import QtQuick

Rectangle {
    id: root

    property var colors: null
    property var netSvc: null
    property var wifiSsid: ""
    property bool  wifiConnected: false

    width: column.implicitWidth + 24
    height: column.implicitHeight + 16
    radius: 12
    color: Qt.hsla(
        Qt.color(colors.surface).hslHue,
        Qt.color(colors.surface).hslSaturation,
        Qt.color(colors.surface).hslLightness,
        0.92)
    border.color: Qt.hsla(
        Qt.color(colors.outline).hslHue,
        Qt.color(colors.outline).hslSaturation,
        Qt.color(colors.outline).hslLightness,
        0.12)
    border.width: 1

    Column {
        id: column
        x: 12
        y: 8
        width: Math.max(240, listColumn.width)
        spacing: 8

        Row {
            id: headerRow
            spacing: 8

            Text {
                text: "\uf1eb  Wi-Fi"
                color: colors.cOnSurface
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                font.weight: Font.Medium
                anchors.verticalCenter: parent.verticalCenter
            }

            Item { width: 1; height: 1; anchors.verticalCenter: parent.verticalCenter }

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
                    onClicked: { if (root.netSvc) root.netSvc.scan() }
                }
            }
        }

        Rectangle {
            height: 1
            width: parent.width
            color: Qt.hsla(
                Qt.color(colors.cOnSurface).hslHue,
                Qt.color(colors.cOnSurface).hslSaturation,
                Qt.color(colors.cOnSurface).hslLightness,
                0.1)
        }

        Row {
            id: toggleRow
            spacing: 8

            Text {
                text: root.netSvc && root.netSvc.enabled ? "On" : "Off"
                color: root.netSvc && root.netSvc.enabled ? colors.primary : Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.4)
                font.pixelSize: 12
                font.family: "JetBrainsMono Nerd Font"
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 36
                height: 18
                radius: 9
                color: root.netSvc && root.netSvc.enabled ? colors.primary : Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.2)
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    x: root.netSvc && root.netSvc.enabled ? 20 : 2
                    y: 2
                    width: 14
                    height: 14
                    radius: 7
                    color: "#ffffff"
                    Behavior on x { NumberAnimation { duration: 100 } }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: { if (root.netSvc) root.netSvc.setEnabled(!root.netSvc.enabled) }
                }
            }
        }

        Column {
            id: listColumn
            width: childrenRect.width
            spacing: 2
            visible: root.netSvc && root.netSvc.enabled

            Text {
                text: "Available Networks"
                color: Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.5)
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font"
                visible: root.netSvc && root.netSvc.availableNetworks && root.netSvc.availableNetworks.length > 0
            }

            Repeater {
                model: root.netSvc ? root.netSvc.availableNetworks : []

                Rectangle {
                    required property var modelData
                    width: Math.max(220, row.implicitWidth + 24)
                    height: 28
                    radius: 6
                    color: mouseArea.containsMouse ? Qt.hsla(
                        Qt.color(colors.cOnSurface).hslHue,
                        Qt.color(colors.cOnSurface).hslSaturation,
                        Qt.color(colors.cOnSurface).hslLightness,
                        0.08) : "transparent"

                    Row {
                        id: row
                        x: 8
                        spacing: 8
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: {
                                var s = modelData.ssid
                                if (s === root.wifiSsid && root.wifiConnected)
                                    return "\u2713 " + s
                                return s
                            }
                            color: modelData.ssid === root.wifiSsid && root.wifiConnected
                                ? colors.primary
                                : colors.cOnSurface
                            font.pixelSize: 12
                            font.family: "JetBrainsMono Nerd Font"
                            elide: Text.ElideRight
                            maximumLineCount: 1
                            width: 140
                        }

                        Text {
                            text: {
                                var sig = modelData.signal
                                if (sig >= 75) return "\u2588\u2588\u2588\u2588"
                                if (sig >= 50) return "\u2588\u2588\u2588\u2582"
                                if (sig >= 25) return "\u2588\u2588\u2582\u2581"
                                return "\u2588\u2582\u2581\u2581"
                            }
                            color: Qt.hsla(
                                Qt.color(colors.cOnSurface).hslHue,
                                Qt.color(colors.cOnSurface).hslSaturation,
                                Qt.color(colors.cOnSurface).hslLightness,
                                0.6)
                            font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: modelData.security && modelData.security !== "--" ? "\uD83D\uDD12" : ""
                            font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (root.netSvc)
                                root.netSvc.connectToNetwork(modelData.ssid)
                        }
                    }
                }
            }
        }
    }
}
