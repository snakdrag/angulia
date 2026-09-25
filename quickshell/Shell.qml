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
        mask: Region { regions: [_launcher.region, ] }
        WlrLayershell.keyboardFocus: _launcher.launcherOpened ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
        Modules.Edge {}
        Modules.Clock {}
        Modules.Launcher { id: _launcher }
    }
    Layers.Overlay {
        mask: Region { regions: [_notifications.region, ] }
        Modules.Notifications { id: _notifications }
    }
}