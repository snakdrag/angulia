pragma Singleton
import Quickshell // for Singleton
import "../services" as Services

Singleton {
    readonly property ObjectModel toplevels: (Services.ToplevelManager.toplevels)

    readonly property var activeToplevel: (Services.ToplevelManager.activeToplevel)
}