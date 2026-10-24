import QtQuick
import Quickshell

ShellRoot {
    id: _

    property int gaps_out: (0)

    property int topExclusiveZone: (0)
    property int leftExclusiveZone: (0)
    property int rightExclusiveZone: (0)
    property int bottomExclusiveZone: (0)

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

    property list<Panel> modules: []

    function setExclusiveZones()
    {
        Qt.callLater(() => {
        this.topExclusiveZone = 0
        this.leftExclusiveZone = 0
        this.rightExclusiveZone = 0
        this.bottomExclusiveZone = 0
        for (let i = 0; i < this.modules.length; i++)
        {
            let module = this.modules[i]
            if (module && module.exclusiveZones !== undefined)
            {
                this.topExclusiveZone = Math.max(this.topExclusiveZone, module.exclusiveZones.top)
                this.leftExclusiveZone = Math.max(this.leftExclusiveZone, module.exclusiveZones.left)
                this.rightExclusiveZone = Math.max(this.rightExclusiveZone, module.exclusiveZones.right)
                this.bottomExclusiveZone = Math.max(this.bottomExclusiveZone, module.exclusiveZones.bottom)
            }
        }})
    }
}