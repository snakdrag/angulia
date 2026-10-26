pragma Singleton
import QtQuick
import Quickshell // for Singleton

Singleton {
    id: _

    readonly property int gaps_out: (Datas.settings.gaps_out)

    property int top: (0)
    property int left: (0)
    property int right: (0)
    property int bottom: (0)

    ExclusiveZone { top: true; exclusiveZone: _.gaps_out + _.top }
    ExclusiveZone { left: true; exclusiveZone: _.gaps_out + _.left }
    ExclusiveZone { right: true; exclusiveZone: _.gaps_out + _.right }
    ExclusiveZone { bottom: true; exclusiveZone: _.gaps_out + _.bottom }

    property list<var> modules: []
    function set()
    {
        Qt.callLater(() => {
        let _top = 0; let _left = 0; let _right = 0; let _bottom = 0
        for (let i = 0; i < this.modules.length; i++)
        {
            let module = this.modules[i]
            if (module && module.exclusiveZones !== undefined && module.exclusiveZoneIgnore)
            {
                if (module.exclusiveZones.top && module.exclusiveZones.top > _top) _top = module.exclusiveZones.top
                if (module.exclusiveZones.left && module.exclusiveZones.left > _left) _left = module.exclusiveZones.left
                if (module.exclusiveZones.right && module.exclusiveZones.right > _right) _right = module.exclusiveZones.right
                if (module.exclusiveZones.bottom && module.exclusiveZones.bottom > _bottom) _bottom = module.exclusiveZones.bottom
            }
        }
        this.top = _top; this.left = _left; this.right = _right; this.bottom = _bottom})
    }
}