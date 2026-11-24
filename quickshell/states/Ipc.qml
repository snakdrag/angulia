pragma Singleton
import Quickshell // for Singleton

Singleton {

    function closeAll()
    {
        Launcher.open = false
        WallpaperSwitcher.open = false
    }
}