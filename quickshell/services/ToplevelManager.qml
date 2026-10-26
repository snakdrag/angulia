pragma Singleton
import Quickshell // for Singleton
import Quickshell.Wayland // for ToplevelManager

Singleton {
    readonly property Toplevel activeToplevel: (ToplevelManager.activeToplevel)

    readonly property ObjectModel toplevels: (ToplevelManager.toplevels)
}