pragma Singleton
import Quickshell // for Singleton

Singleton {

    readonly property bool open: (
        WallpaperSwitcher.open ||
        Launcher.open
    )

    function closeAll()
    {
        Launcher.ipc.close()
        WallpaperSwitcher.ipc.close()
    }
}