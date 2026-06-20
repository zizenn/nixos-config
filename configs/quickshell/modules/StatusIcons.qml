import QtQuick

Row {
    id: root

    property var colors: null
    property string wifiSsid: ""
    property bool   wifiConnected: false
    property bool   btPowered: false
    property int    btCount: 0

    spacing: 14
    anchors.verticalCenter: parent.verticalCenter

    Row {
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter

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

    Row {
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter
        visible: root.btPowered

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
