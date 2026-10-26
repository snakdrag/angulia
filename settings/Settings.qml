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
        onFileChanged: this.reload()
    }

    readonly property Colors colors: (Colors)

    readonly property real radius: (this.data.radius)
    readonly property int edge: (this.data.edge)

    readonly property int float: (this.data.float)
    readonly property int space: (this.data.space)

    readonly property int gaps_out: (this.data.gaps_out)

    readonly property var clock: (this.data.clock)
    readonly property var popup: (this.data.popup)
    readonly property var polkit: (this.data.polkit)
    readonly property var launcher: (this.data.launcher)
    readonly property var systemtray: (this.data.systemtray)
    readonly property var activewindow: (this.data.activewindow)
    readonly property var notifications: (this.data.notifications)
    readonly property var wallpaperswitcher: (this.data.wallpaperswitcher)
}