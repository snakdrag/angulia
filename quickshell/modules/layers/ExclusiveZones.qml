import Quickshell
import Quickshell.Wayland

ShellRoot {
    id: _
    property int exclusiveZones: (0)
    property int topExclusiveZone: (exclusiveZones)
    property int leftExclusiveZone: (exclusiveZones)
    property int rightExclusiveZone: (exclusiveZones)
    property int bottomExclusiveZone: (exclusiveZones)
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