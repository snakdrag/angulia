import Quickshell
import Quickshell.Wayland
import qs.angulia.quickshell.settings

ShellRoot {
    id: _
    property int exclusiveZones: (Decorations.exclusiveZones)
    property int topExclusiveZone: (Decorations.topExclusiveZone)
    property int leftExclusiveZone: (Decorations.leftExclusiveZone)
    property int rightExclusiveZone: (Decorations.rightExclusiveZone)
    property int bottomExclusiveZone: (Decorations.bottomExclusiveZone)
    PanelWindow {
        anchors.top: true
        exclusiveZone: _.topExclusiveZone
        color: "transparent"
        mask: Region {}
        WlrLayershell.layer: WlrLayer.Background
    }
    PanelWindow {
        anchors.left: true
        exclusiveZone: _.leftExclusiveZone
        color: "transparent"
        mask: Region {}
        WlrLayershell.layer: WlrLayer.Background
    }
    PanelWindow {
        anchors.right: true
        exclusiveZone: _.rightExclusiveZone
        color: "transparent"
        mask: Region {}
        WlrLayershell.layer: WlrLayer.Background
    }
    PanelWindow {
        anchors.bottom: true
        exclusiveZone: _.bottomExclusiveZone
        color: "transparent"
        mask: Region {}
        WlrLayershell.layer: WlrLayer.Background
    }
}