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

    readonly property var bar: (this.data.bar)
    readonly property var notification: (this.data.notification)
    readonly property var launcher: (this.data.launcher)
    readonly property var clock: (this.data.clock)
    readonly property var systemtray: (this.data.systemtray)
    readonly property var wallpaperswitcher: (this.data.wallpaperswitcher)
}