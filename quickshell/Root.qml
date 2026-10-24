import QtQuick
import Quickshell

ShellRoot {
    id: _

    property list<Item> modules: ([])
    property list<Item> childrens: ([])

    property bool _top: (false)
    property bool _left: (false)
    property bool _right: (false)
    property bool _bottom: (false)

    property var bar: ({})
    property int gaps_out: (0)
    property int float: (0)
    property int edge: (0)

    property int topExclusiveZone: (this.edge + (this._top ? this.float + this.bar.height: 0))
    property int leftExclusiveZone: (this.edge + (this._left ? this.float + this.bar.width: 0))
    property int rightExclusiveZone: (this.edge + (this._right ? this.float + this.bar.width: 0))
    property int bottomExclusiveZone: (this.edge + (this._bottom ? this.float + this.bar.height: 0))

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

    function ipcCloseAll()
    {
        for (let i = 0; i < this.childrens.length; i++) {
            let child = this.childrens[i]
            if (child && child.ipc !== undefined)
            {
                child.ipc.close()
            }
        }
        _popup.close()
    }
    function set()
    {
        Qt.callLater(() => {
        this.topExclusiveZone = 0
        this.leftExclusiveZone = 0
        this.rightExclusiveZone = 0
        this.bottomExclusiveZone = 0
        for (let i = 0; i < this.modules.length; i++) {
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
    function check()
    {
        Qt.callLater(() => {
        let angulia = []
        for (let i = 0; i < this.childrens.length; i++) {
            let child = this.childrens[i]
            if (child && child.roundcorners !== undefined)
            {
                angulia.push(child)
                child.roundcorners.isTopLeft = false
                child.roundcorners.isTopRight = false
                child.roundcorners.isLeftTop = false
                child.roundcorners.isLeftBottom = false
                child.roundcorners.isRightTop = false
                child.roundcorners.isRightBottom = false
                child.roundcorners.isBottomLeft = false
                child.roundcorners.isBottomRight = false
            }
        }
        for (let i = 0; i < angulia.length; i++) {
            for (let j = i + 1; j < angulia.length; j++) {
                let a1 = angulia[i]
                let a2 = angulia[j]

                let a1XWidth = a1.x + a1.width
                let a1YHeight = a1.y + a1.height
                let a2XWidth = a2.x + a2.width
                let a2YHeight = a2.y + a2.height

                // let a1w = a1.roundcorners.widthRadius + a2.roundcorners.finalRadius
                // let a1h = a1.roundcorners.heightRadius + a2.roundcorners.finalRadius
                // let a2w = a2.roundcorners.widthRadius + a1.roundcorners.finalRadius
                // let a2h = a2.roundcorners.heightRadius + a1.roundcorners.finalRadius

                let a1w = 0
                let a1h = 0
                let a2w = 0
                let a2h = 0

                let a1_Top = a2.y + a1w <= a1.y && a1.y <= a2YHeight
                let a1_Left = a2.x + a1h <= a1.x && a1.x <= a2XWidth
                let a1_Right = a2.x <= a1XWidth && a1XWidth <= a2XWidth - a1h
                let a1_Bottom = a2.y <= a1YHeight && a1YHeight <= a2YHeight - a1w
                let a2_Top = a1.y + a2w <= a2.y && a2.y <= a1YHeight
                let a2_Left = a1.x + a2h <= a2.x && a2.x <= a1XWidth
                let a2_Right = a1.x <= a2XWidth && a2XWidth <= a1XWidth - a2h
                let a2_Bottom = a1.y <= a2YHeight && a2YHeight <= a1YHeight - a2w

                if (a1.y == a2YHeight)
                {
                    if (a1_Left && a2_Left)
                    {
                        a1.roundcorners.isTopLeft = true
                        a2.roundcorners.isBottomLeft = true
                    }
                    if (a1_Right && a2_Right) a1.roundcorners.isTopRight = true
                    if (a2_Right && a1_Right) a2.roundcorners.isBottomRight = true
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftTop = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightTop = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftBottom = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightBottom = true
                }
                if (a1.x == a2XWidth)
                {
                    if (a1_Top && a2_Top)
                    {
                        a1.roundcorners.isLeftTop = true
                        a2.roundcorners.isRightTop = true
                    }
                    if (a1_Bottom && a2_Bottom)
                    {
                        a1.roundcorners.isLeftBottom = true
                        a2.roundcorners.isRightBottom = true
                    }
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopLeft = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomRight = true
                }
                if (a1XWidth == a2.x)
                {
                    if (a1_Top && a2_Top) a1.roundcorners.isRightTop = true
                    if (a2_Top && a1_Top) a2.roundcorners.isLeftTop = true
                    if (a1_Bottom && a2_Bottom) a1.roundcorners.isRightBottom = true
                    if (a2_Bottom && a1_Bottom) a2.roundcorners.isLeftBottom = true
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomRight = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomLeft = true
                }
                if (a1YHeight == a2.y)
                {
                    if (a1_Left && a2_Left) a1.roundcorners.isBottomLeft = true
                    if (a2_Left && a1_Left) a2.roundcorners.isTopLeft = true
                    if (a1_Right && a2_Right) a1.roundcorners.isBottomRight = true
                    if (a2_Right && a1_Right) a2.roundcorners.isTopRight = true
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftBottom = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightBottom = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftTop = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightTop = true
                }
            }
        }})
    }
}