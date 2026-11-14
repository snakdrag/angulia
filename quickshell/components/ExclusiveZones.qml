pragma Singleton
import QtQuick
import Quickshell

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
        Qt.callLater(
            () => {
            let _top = 0;
            let _left = 0;
            let _right = 0;
            let _bottom = 0;
            for (let i = 0; i < this.modules.length; i++)
            {
                let module = this.modules[i];
                if (module && module.exclusiveZoneIgnore && module.visible)
                {
                    let mT = module.anchors.topMargin + module.height;
                    let mL = module.anchors.leftMargin + module.width;
                    let mR = module.anchors.rightMargin + module.width;
                    let mB = module.anchors.bottomMargin + module.height;
                    if (module.isTop && _top < mT) _top = mT;
                    if (module.isLeft && _left < mL) _left = mL;
                    if (module.isRight && _right < mR) _right = mR;
                    if (module.isBottom && _bottom < mB) _bottom = mB;
                }
            }
            this.top = _top;
            this.left = _left;
            this.right = _right;
            this.bottom = _bottom;
        })
    }
}