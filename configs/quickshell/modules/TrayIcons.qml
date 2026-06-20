import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: trayItems.length > 0

    property var trayItems: []

    onVisibleChanged: {
        if (visible) {
            var arr = []
            for (var i = 0; i < SystemTray.items.length; i++)
                arr.push(SystemTray.items[i])
            trayItems = arr
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var arr = []
            for (var i = 0; i < SystemTray.items.length; i++)
                arr.push(SystemTray.items[i])
            trayItems = arr
        }
    }

    Repeater {
        model: trayItems

        delegate: Item {
            required property var modelData
            width: 20; height: 20

            Image {
                anchors.fill: parent
                source: modelData.icon
                fillMode: Image.PreserveAspectFit
                smooth: true
                asynchronous: true
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
