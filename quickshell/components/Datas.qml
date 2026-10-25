pragma Singleton
import Quickshell // for Singleton
import qs.angulia.settings

Singleton {
    readonly property var settings: (Settings)
    readonly property var colors: (this.settings.colors)
}