import QtQuick
import "../colors.js" as Colors

Item {
    id: root

    property alias query: searchInput.text
    property var launcherModel: null
    signal closeRequested()

    implicitWidth: col.implicitWidth
    implicitHeight: col.implicitHeight

    Column {
        id: col
        spacing: 8
        width: parent.width

        Rectangle {
            width: parent.width
            height: 32
            radius: 8
            color: Qt.hsla(
                Qt.color(Colors.surfaceVariant).hslHue,
                Qt.color(Colors.surfaceVariant).hslSaturation,
                Qt.color(Colors.surfaceVariant).hslLightness,
                0.3)
            border.color: Qt.hsla(
                Qt.color(Colors.outline).hslHue,
                Qt.color(Colors.outline).hslSaturation,
                Qt.color(Colors.outline).hslLightness,
                0.12)
            border.width: 1

            Row {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10 }
                spacing: 8

                Text {
                    text: "\uf4a5"
                    color: Qt.hsla(
                        Qt.color(Colors.onSurface).hslHue,
                        Qt.color(Colors.onSurface).hslSaturation,
                        Qt.color(Colors.onSurface).hslLightness,
                        0.5)
                    font.pixelSize: 13
                    font.family: "JetBrainsMono Nerd Font"
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextInput {
                    id: searchInput
                    width: 280
                    color: Colors.onSurface
                    font.pixelSize: 13
                    selectionColor: Qt.hsla(
                        Qt.color(Colors.primary).hslHue,
                        Qt.color(Colors.primary).hslSaturation,
                        Qt.color(Colors.primary).hslLightness,
                        0.4)
                    placeholderText: qsTr("Search apps\u2026")
                    placeholderTextColor: Qt.hsla(
                        Qt.color(Colors.onSurface).hslHue,
                        Qt.color(Colors.onSurface).hslSaturation,
                        Qt.color(Colors.onSurface).hslLightness,
                        0.3)
                    focus: true
                    clip: true

                    onTextChanged: {
                        if (root.launcherModel)
                            root.launcherModel.query = text
                    }

                    Keys.onEscapePressed: root.closeRequested()
                    Keys.onReturnPressed: {
                        if (appList.count > 0) {
                            root.launcherModel.launch(root.launcherModel.filteredApps[0].exec)
                        }
                        root.closeRequested()
                    }
                }
            }
        }

        Column {
            id: appList
            width: parent.width
            spacing: 2

            property int count: root.launcherModel ? root.launcherModel.filteredApps.length : 0

            Repeater {
                model: root.launcherModel ? root.launcherModel.filteredApps : []

                delegate: Rectangle {
                    required property var modelData
                    required property int index

                    width: col.width
                    height: 36
                    radius: 8
                    color: appArea.containsMouse
                        ? Qt.hsla(
                            Qt.color(Colors.primary).hslHue,
                            Qt.color(Colors.primary).hslSaturation,
                            Qt.color(Colors.primary).hslLightness,
                            0.15)
                        : "transparent"

                    Behavior on color { ColorAnimation { duration: 100 } }

                    Row {
                        anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10 }
                        spacing: 10

                        Image {
                            width: 22; height: 22
                            source: modelData.icon.startsWith("/") || modelData.icon.startsWith("file://")
                                    ? modelData.icon
                                    : "image://xdgicon/" + modelData.icon
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                            smooth: true
                        }

                        Text {
                            text: modelData.name
                            color: Colors.onSurface
                            font.pixelSize: 13
                            anchors.verticalCenter: parent.verticalCenter
                            elide: Text.ElideRight
                            width: 270
                        }
                    }

                    MouseArea {
                        id: appArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.launcherModel.launch(modelData.exec)
                            root.closeRequested()
                        }
                    }
                }
            }
        }
    }
}
