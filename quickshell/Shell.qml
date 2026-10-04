import Quickshell
import Quickshell.Wayland
import "modules" as Modules
import "layers" as Layers
import "../settings"
import "../theme"

ShellRoot {
    Layers.ExclusiveZones {
        exclusiveZones: Settings.exclusiveZones
        topExclusiveZone: Settings.topExclusiveZone
        leftExclusiveZone: Settings.leftExclusiveZone
        rightExclusiveZone: Settings.rightExclusiveZone
        bottomExclusiveZone: Settings.bottomExclusiveZone
    }
    Layers.Overlay {
        id: _overlay
        mask: Region { regions: [_notifications.region,] }
        WlrLayershell.keyboardFocus: _launcher.show ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
        Modules.Notifications { id: _notifications; direction: Settings.notificationDirection % 8 }
        Modules.Launcher { id: _launcher; direction: Settings.launcherDirection }
    }
    Layers.Top {
        id: _top
        mask: Region { regions: [_systemtray.region,] }
        Modules.Edge {}
        Modules.Clock { direction: Settings.clockDirection }
        Modules.SystemTray { id: _systemtray; direction: Settings.systemtrayDirection; cardColor: "transparent" }
    }
    // Layers.Bottom {
    //     mask: Region {}
    // }
    // Layers.Background {
    //     mask: Region {}
    // }
}