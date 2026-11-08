pragma Singleton
import QtQuick
import Quickshell // for Singleton

Singleton {
    id: _

    property int top: (0)
    property int left: (0)
    property int right: (0)
    property int bottom: (0)
    property list<var> modules: []
    readonly property int gaps_out: (Datas.settings.gaps_out)

    component ExclusiveZone: PanelWindow { implicitWidth: 0; implicitHeight: 0 }

    ExclusiveZone { anchors.top: true; exclusiveZone: _.gaps_out + _.top }
    ExclusiveZone { anchors.left: true; exclusiveZone: _.gaps_out + _.left }
    ExclusiveZone { anchors.right: true; exclusiveZone: _.gaps_out + _.right }
    ExclusiveZone { anchors.bottom: true; exclusiveZone: _.gaps_out + _.bottom }

    function set()
    {
        Qt.callLater(() => {
        let _top = 0; let _left = 0; let _right = 0; let _bottom = 0
        for (let i = 0; i < this.modules.length; i++)
        {
            let module = this.modules[i]
            if (module && module.exclusiveZones !== undefined && module.exclusiveZoneIgnore)
            {
                if (module.exclusiveZones.top > _top) _top = module.exclusiveZones.top
                if (module.exclusiveZones.left > _left) _left = module.exclusiveZones.left
                if (module.exclusiveZones.right > _right) _right = module.exclusiveZones.right
                if (module.exclusiveZones.bottom > _bottom) _bottom = module.exclusiveZones.bottom
            }
        }
        this.top = _top; this.left = _left; this.right = _right; this.bottom = _bottom})
    }
}