import Quickshell 
import Quickshell.Wayland
import "modules" as Modules
import "layers" as Layers

ShellRoot {
    Layers.ExclusiveZones {}
    // Layers.Background {
    //     mask: Region {}
    // }
    // Layers.Bottom {
    //     mask: Region {}
    // }
    Layers.Top {
        Modules.Edge {}
        Modules.Clock {}
    }
    Layers.Overlay {
        mask: Region { regions: [_notifications.region, _launcher.region,] }
        WlrLayershell.keyboardFocus: _launcher.launcherOpened ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
        Modules.Notifications { id: _notifications }
        Modules.Launcher { id: _launcher }
    }
}