import QtQuick
import "../colors.js" as Colors

Item {
    id: root

    property var workspaces: []
    property int activeId: 1
    signal switchRequested(int id)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    Row {
        id: row
        spacing: 5
        anchors.centerIn: parent

        Repeater {
            model: root.workspaces

            Rectangle {
                required property var modelData

                property bool isActive: modelData.id === root.activeId

                width:  isActive ? 20 : 7
                height: 7
                radius: 3.5

                color: isActive ? Colors.primary : Qt.hsla(
                    Qt.color(Colors.onSurface).hslHue,
                    Qt.color(Colors.onSurface).hslSaturation,
                    Qt.color(Colors.onSurface).hslLightness,
                    0.3)

                Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 150 } }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.switchRequested(modelData.id)
                }
            }
        }
    }
}
