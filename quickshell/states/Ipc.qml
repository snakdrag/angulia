pragma Singleton
import Quickshell // for Singleton

Singleton {

    property bool active: (false)
    readonly property bool open: (
        WallpaperSwitcher.open ||
        Launcher.open
    )

    function closeAll()
    {
        Launcher.open = false
        WallpaperSwitcher.open = false
    }
}