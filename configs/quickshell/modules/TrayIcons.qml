import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        model: SystemTray.items

        Item {
            required property SystemTrayItem modelData
            width: 20; height: 20

            Image {
                anchors.fill: parent
                source: modelData.icon
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: function(mouse) {
                    if (mouse.button === Qt.LeftButton)
                        modelData.activate()
                    else
                        modelData.secondaryActivate()
                }
            }
        }
    }
}
