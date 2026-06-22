import QtQuick

Row {
    id: root

    property var colors: null
    property string wifiSsid: ""
    property bool   wifiConnected: false
    property bool   btPowered: false
    property int    btCount: 0

    signal wifiClicked()
    signal btClicked()
    signal powerClicked()
    signal calendarClicked()

    spacing: 14
    anchors.verticalCenter: parent.verticalCenter

    Item {
        id: wifiGroup
        implicitWidth: wifiRow.implicitWidth
        implicitHeight: wifiRow.implicitHeight

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.wifiClicked()
        }

        Row {
            id: wifiRow
            spacing: 6

            Text {
                id: wifiIcon
                text: "\uf1eb"
                color: root.wifiConnected
                    ? root.colors.primary
                    : Qt.hsla(
                        Qt.color(root.colors.cOnSurface).hslHue,
                        Qt.color(root.colors.cOnSurface).hslSaturation,
                        Qt.color(root.colors.cOnSurface).hslLightness,
                        0.4)
                font.pixelSize: 15
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                text: root.wifiConnected ? root.wifiSsid : "offline"
                color: Qt.hsla(
                    Qt.color(root.colors.cOnSurface).hslHue,
                    Qt.color(root.colors.cOnSurface).hslSaturation,
                    Qt.color(root.colors.cOnSurface).hslLightness,
                    0.7)
                font.pixelSize: 11
            }
        }
    }

    Item {
        id: btGroup
        implicitWidth: btRow.implicitWidth
        implicitHeight: btRow.implicitHeight
        visible: root.btPowered

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.btClicked()
        }

        Row {
            id: btRow
            spacing: 6

            Text {
                text: "\uf294"
                color: root.btCount > 0
                    ? root.colors.primary
                    : Qt.hsla(
                        Qt.color(root.colors.cOnSurface).hslHue,
                        Qt.color(root.colors.cOnSurface).hslSaturation,
                        Qt.color(root.colors.cOnSurface).hslLightness,
                        0.4)
                font.pixelSize: 15
                font.family: "JetBrainsMono Nerd Font"
            }

            Text {
                visible: root.btCount > 0
                text: root.btCount + " dev"
                color: Qt.hsla(
                    Qt.color(root.colors.cOnSurface).hslHue,
                    Qt.color(root.colors.cOnSurface).hslSaturation,
                    Qt.color(root.colors.cOnSurface).hslLightness,
                    0.7)
                font.pixelSize: 11
            }
        }
    }

    Text {
        text: "\uf011"
        color: "#ff4444"
        font.pixelSize: 15
        font.family: "JetBrainsMono Nerd Font"
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.powerClicked()
        }
    }

    Text {
        text: "\uf073"
        color: colors.cOnSurface
        font.pixelSize: 15
        font.family: "JetBrainsMono Nerd Font"
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.calendarClicked()
        }
    }
}
