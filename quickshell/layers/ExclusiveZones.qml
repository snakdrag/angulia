import Quickshell

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