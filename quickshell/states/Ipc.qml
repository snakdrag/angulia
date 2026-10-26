pragma Singleton
import Quickshell // for Singleton

Singleton {

    function closeAll()
    {
        Launcher.ipc.close()
        WallpaperSwitcher.ipc.close()
    }
}