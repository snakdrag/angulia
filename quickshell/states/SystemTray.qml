pragma Singleton
import Quickshell // for Singleton
import "../services" as Services

Singleton {
    readonly property ObjectModel items: (Services.SystemTray.items)
}