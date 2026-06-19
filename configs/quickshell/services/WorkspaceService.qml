import QtQuick
import Quickshell
import Quickshell.Hyprland

QtObject {
    id: root

    property int activeId: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1

    property var workspaces: {
        var raw = Hyprland.workspaces
        var out = []
        for (var i = 0; i < raw.length; i++) {
            var ws = raw[i]
            out.push({ id: ws.id, name: ws.name })
        }
        out.sort(function(a, b) { return a.id - b.id })
        return out
    }

    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            root.activeId = Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
        }
        function onWorkspacesChanged() {
            root.workspacesChanged()
        }
    }

    function switchTo(id) {
        Hyprland.dispatch("workspace " + id)
    }
}
