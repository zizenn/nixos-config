import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property color surface: "#1e1e24"
    property color cOnSurface: "#e2e2e9"
    property color surfaceDim: "#131318"
    property color surfaceBright: "#35353b"
    property color surfaceContainer: "#24242a"
    property color surfaceVariant: "#44474e"
    property color cOnSurfaceVariant: "#c4c6d0"
    property color primary: "#acc7ff"
    property color cOnPrimary: "#0e2f60"
    property color primaryContainer: "#2a4677"
    property color cOnPrimaryContainer: "#d7e2ff"
    property color secondary: "#bcc7db"
    property color cOnSecondary: "#26313e"
    property color secondaryContainer: "#3d4759"
    property color cOnSecondaryContainer: "#d8e3f8"
    property color tertiary: "#e2bdd6"
    property color cOnTertiary: "#3f2942"
    property color error: "#ffb4ab"
    property color cOnError: "#690005"
    property color errorContainer: "#93000a"
    property color cOnErrorContainer: "#ffdad6"
    property color outline: "#8e9099"
    property color outlineVariant: "#44474e"
    property color background: "#111318"
    property color cOnBackground: "#e2e2e9"

    property Timer pollTimer: Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.poll()
    }

    property Process reader: Process {
        command: ["bash", "-c", "tr -d '\\n' < ~/.config/quickshell/colors.json 2>/dev/null || echo '{}'"]
        running: false
        stdout: SplitParser {
            onRead: function(data) {
                root.buf += data
            }
        }
        onExited: {
            root.parse(root.buf)
            root.buf = ""
        }
    }

    property string buf: ""

    function poll() {
        if (!reader.running)
            reader.running = true
    }

    function parse(text) {
        if (!text) return
        try {
            var json = JSON.parse(text)
            if (json.surface)             root.surface = json.surface
            if (json.cOnSurface)          root.cOnSurface = json.cOnSurface
            if (json.surfaceDim)          root.surfaceDim = json.surfaceDim
            if (json.surfaceBright)       root.surfaceBright = json.surfaceBright
            if (json.surfaceContainer)    root.surfaceContainer = json.surfaceContainer
            if (json.surfaceVariant)      root.surfaceVariant = json.surfaceVariant
            if (json.cOnSurfaceVariant)   root.cOnSurfaceVariant = json.cOnSurfaceVariant
            if (json.primary)             root.primary = json.primary
            if (json.cOnPrimary)          root.cOnPrimary = json.cOnPrimary
            if (json.primaryContainer)    root.primaryContainer = json.primaryContainer
            if (json.cOnPrimaryContainer) root.cOnPrimaryContainer = json.cOnPrimaryContainer
            if (json.secondary)           root.secondary = json.secondary
            if (json.cOnSecondary)        root.cOnSecondary = json.cOnSecondary
            if (json.secondaryContainer)  root.secondaryContainer = json.secondaryContainer
            if (json.cOnSecondaryContainer) root.cOnSecondaryContainer = json.cOnSecondaryContainer
            if (json.tertiary)            root.tertiary = json.tertiary
            if (json.cOnTertiary)         root.cOnTertiary = json.cOnTertiary
            if (json.error)               root.error = json.error
            if (json.cOnError)            root.cOnError = json.cOnError
            if (json.errorContainer)      root.errorContainer = json.errorContainer
            if (json.cOnErrorContainer)   root.cOnErrorContainer = json.cOnErrorContainer
            if (json.outline)             root.outline = json.outline
            if (json.outlineVariant)      root.outlineVariant = json.outlineVariant
            if (json.background)          root.background = json.background
            if (json.cOnBackground)       root.cOnBackground = json.cOnBackground
        } catch (e) {}
    }
}
