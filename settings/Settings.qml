pragma Singleton
import Quickshell // for Singleton and Quickshell.env
import Quickshell.Io // for FileView and JSON.parse
import "colors" // for Colors

Singleton {

    readonly property var data: (JSON.parse(_angulia.text()))
    FileView {
        id: _angulia
        path: Quickshell.env("HOME") + "/.config/angulia/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    readonly property Colors colors: (Colors)

    readonly property real radius: (data.radius)
    readonly property int edge: (data.edge)

    readonly property int float: (data.float)
    readonly property int space: (data.space)

    readonly property int gaps_out: (data.gaps_out)

    readonly property var bar: (data.bar)
    readonly property var notification: (data.notification)
    readonly property var launcher: (data.launcher)
    readonly property var clock: (data.clock)
    readonly property var systemtray: (data.systemtray)
    readonly property var wallpaperswitcher: (data.wallpaperswitcher)
}