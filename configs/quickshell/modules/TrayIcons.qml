import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    visible: true

    property var trayItems: []

    function refresh() {
        var arr = []
        if (SystemTray && SystemTray.items) {
            for (var i = 0; i < SystemTray.items.length; i++)
                arr.push(SystemTray.items[i])
        }
        trayItems = arr
    }

    Text {
        text: "tray:" + trayItems.length
        color: "red"; font.pixelSize: 10
        anchors.verticalCenter: parent.verticalCenter
        visible: true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: refresh()
    }

    Repeater {
        model: trayItems

        delegate: Item {
            required property var modelData
            width: 20; height: 20

            Image {
                anchors.fill: parent
                source: modelData ? modelData.icon : ""
                fillMode: Image.PreserveAspectFit
                smooth: true
                asynchronous: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.PointingHandCursor
                onClicked: function(mouse) {
                    if (!modelData) return
                    if (mouse.button === Qt.LeftButton)
                        modelData.activate()
                    else
                        modelData.secondaryActivate()
                }
            }
        }
    }
}
