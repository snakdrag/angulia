pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.SystemTray

Singleton {
    readonly property ObjectModel items: (SystemTray.items)

    readonly property var status: (Status)
    readonly property var category: (Category)
}