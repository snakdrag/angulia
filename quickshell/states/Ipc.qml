pragma Singleton
import QtQuick
import Quickshell // for Singleton
import Quickshell.Io

Singleton {
    function closeAll()
    {
        Launcher.ipc.close()
        WallpaperSwitcher.ipc.close()
    }
}