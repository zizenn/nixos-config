import QtQuick

Rectangle {
    id: root

    property var colors: null
    property var btSvc: null

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
                text: "\uf294  Bluetooth"
                color: colors.cOnSurface
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                font.weight: Font.Medium
                anchors.verticalCenter: parent.verticalCenter
            }

            Item { width: 1; height: 1; anchors.verticalCenter: parent.verticalCenter }

            Text {
                text: root.btSvc && root.btSvc.discovering ? "\uf28e" : "\uf021"
                color: colors.cOnSurface
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 11
                opacity: 0.5
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (!root.btSvc) return
                        if (root.btSvc.discovering)
                            root.btSvc.stopDiscovery()
                        else
                            root.btSvc.startDiscovery()
                    }
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
                text: root.btSvc && root.btSvc.powered ? "On" : "Off"
                color: root.btSvc && root.btSvc.powered ? colors.primary : Qt.hsla(
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
                color: root.btSvc && root.btSvc.powered ? colors.primary : Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.2)
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    x: root.btSvc && root.btSvc.powered ? 20 : 2
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
                    onClicked: { if (root.btSvc) root.btSvc.setEnabled(!root.btSvc.powered) }
                }
            }
        }

        Column {
            id: listColumn
            width: childrenRect.width
            spacing: 2
            visible: root.btSvc && root.btSvc.powered

            Text {
                text: "Devices"
                color: Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.5)
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font"
                visible: root.btSvc && root.btSvc.availableDevices && root.btSvc.availableDevices.length > 0
            }

            Repeater {
                model: root.btSvc ? root.btSvc.availableDevices : []

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
                                var d = modelData
                                if (d.connected)
                                    return "\u2713 " + d.name
                                if (d.name)
                                    return d.name
                                return d.address
                            }
                            color: modelData.connected ? colors.primary : colors.cOnSurface
                            font.pixelSize: 12
                            font.family: "JetBrainsMono Nerd Font"
                            elide: Text.ElideRight
                            maximumLineCount: 1
                            width: 150
                        }

                        Text {
                            text: modelData.connected ? "Connected" : ""
                            color: Qt.hsla(
                                Qt.color(colors.cOnSurface).hslHue,
                                Qt.color(colors.cOnSurface).hslSaturation,
                                Qt.color(colors.cOnSurface).hslLightness,
                                0.5)
                            font.pixelSize: 10
                            font.family: "JetBrainsMono Nerd Font"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (!root.btSvc) return
                            if (modelData.connected)
                                root.btSvc.disconnectDevice(modelData.address)
                            else
                                root.btSvc.connectToDevice(modelData.address)
                        }
                    }
                }
            }

            Text {
                text: root.btSvc && root.btSvc.discovering ? "Discovering..." : ""
                color: Qt.hsla(
                    Qt.color(colors.cOnSurface).hslHue,
                    Qt.color(colors.cOnSurface).hslSaturation,
                    Qt.color(colors.cOnSurface).hslLightness,
                    0.4)
                font.pixelSize: 10
                font.family: "JetBrainsMono Nerd Font"
                font.italic: true
                visible: root.btSvc && root.btSvc.discovering
            }
        }
    }
}
