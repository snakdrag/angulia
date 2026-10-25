pragma Singleton
import Quickshell // for Singleton

Singleton {
    id: _

    readonly property int gaps_out: (Datas.settings.gaps_out)
    readonly property int edge: (Datas.settings.edge)

    property int top: (0)
    property int left: (0)
    property int right: (0)
    property int bottom: (0)

    PanelWindow {
        anchors.top: true
        exclusiveZone: _.gaps_out + _.top
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.left: true
        exclusiveZone: _.gaps_out + _.left
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.right: true
        exclusiveZone: _.gaps_out + _.right
        implicitWidth: 0
        implicitHeight: 0
    }
    PanelWindow {
        anchors.bottom: true
        exclusiveZone: _.gaps_out + _.bottom
        implicitWidth: 0
        implicitHeight: 0
    }

    property list<var> modules: []
    function set()
    {
        Qt.callLater(() => {
        this.top = 0
        this.left = 0
        this.right = 0
        this.bottom = 0
        for (let i = 0; i < this.modules.length; i++)
        {
            let module = this.modules[i]
            if (module && module.exclusiveZones !== undefined && module.exclusiveZoneIgnore)
            {
                if (module.exclusiveZones.top && module.exclusiveZones.top > this.top)
                    this.top = module.exclusiveZones.top
                if (module.exclusiveZones.left && module.exclusiveZones.left > this.left)
                    this.left = module.exclusiveZones.left
                if (module.exclusiveZones.right && module.exclusiveZones.right > this.right)
                    this.right = module.exclusiveZones.right
                if (module.exclusiveZones.bottom && module.exclusiveZones.bottom > this.bottom)
                    this.bottom = module.exclusiveZones.bottom
            }
        }})
    }
}