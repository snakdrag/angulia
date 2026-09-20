import Quickshell 
import Quickshell.Wayland
import "layers" as Layers
import "top" as Top
import "overlay" as Overlay

ShellRoot {
    Layers.ExclusiveZones {}
    Layers.Background {
        mask: Region {}
    }
    Layers.Bottom {
        mask: Region {}
    }
    Layers.Top {
        mask: Region { regions: [_launcher.region, ] }
        WlrLayershell.keyboardFocus: _launcher.launcherOpened ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
        Top.Edge {}
        Top.Clock {}
        Top.Launcher { id: _launcher }
        Top.Notifications { contentHeight: _notifications.contentHeight }
    }
    Layers.Overlay {
        mask: Region { regions: [_notifications.region, ] }
        Overlay.Notifications { id: _notifications }
    }
}