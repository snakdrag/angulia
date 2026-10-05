import Quickshell

ShellRoot {
    id: _
    property int gaps_out: (0)
    property int exclusiveZones: (0)
    property int topExclusiveZone: (exclusiveZones)
    property int leftExclusiveZone: (exclusiveZones)
    property int rightExclusiveZone: (exclusiveZones)
    property int bottomExclusiveZone: (exclusiveZones)
    PanelWindow {
        anchors.top: true
        exclusiveZone: _.gaps_out + _.topExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.left: true
        exclusiveZone: _.gaps_out + _.leftExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.right: true
        exclusiveZone: _.gaps_out + _.rightExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.bottom: true
        exclusiveZone: _.gaps_out + _.bottomExclusiveZone
        implicitWidth: 0
        implicitHeight: 0
    }
}