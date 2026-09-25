import Quickshell
import qs.angulia.theme

ShellRoot {
    id: _
    property int exclusiveZones: (Settings.exclusiveZones)
    property int topExclusiveZone: (Settings.topExclusiveZone)
    property int leftExclusiveZone: (Settings.leftExclusiveZone)
    property int rightExclusiveZone: (Settings.rightExclusiveZone)
    property int bottomExclusiveZone: (Settings.bottomExclusiveZone)
    PanelWindow {
        anchors.top: true
        exclusiveZone: _.topExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.left: true
        exclusiveZone: _.leftExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.right: true
        exclusiveZone: _.rightExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.bottom: true
        exclusiveZone: _.bottomExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
}