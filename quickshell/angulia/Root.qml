import QtQuick
import Quickshell
import "../../settings"

ShellRoot {
    id: _

    property list<Item> modules: ([])
    property list<Item> childrens: ([])

    property bool _top: (false)
    property bool _left: (false)
    property bool _right: (false)
    property bool _bottom: (false)

    readonly property int gaps_out: (Settings.gaps_out)
    readonly property int topExclusiveZone: (Settings.edge + (this._top ? Settings.float + Settings.bar.height: 0))
    readonly property int leftExclusiveZone: (Settings.edge + (this._left ? Settings.float + Settings.bar.width: 0))
    readonly property int rightExclusiveZone: (Settings.edge + (this._right ? Settings.float + Settings.bar.width: 0))
    readonly property int bottomExclusiveZone: (Settings.edge + (this._bottom ? Settings.float + Settings.bar.height: 0))

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
    }
    function set()
    {
        Qt.callLater(() => {
        this._top = false
        this._left = false
        this._right = false
        this._bottom = false
        for (let i = 0; i < this.modules.length; i++) {
            let module = this.modules[i]
            if (module && module.roundcorners !== undefined)
            {
                this._top = this._top || module.isTop
                this._left = this._left || module.isLeft
                this._right = this._right || module.isRight
                this._bottom = this._bottom || module.isBottom
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

                let a1_Top = a2.y <= a1.y && a1.y <= a2YHeight
                let a1_Left = a2.x <= a1.x && a1.x <= a2XWidth
                let a1_Right = a2.x <= a1XWidth && a1XWidth <= a2XWidth
                let a1_Bottom = a2.y <= a1YHeight && a1YHeight <= a2YHeight
                let a2_Top = a1.y <= a2.y && a2.y <= a1YHeight
                let a2_Left = a1.x <= a2.x && a2.x <= a1XWidth
                let a2_Right = a1.x <= a2XWidth && a2XWidth <= a1XWidth
                let a2_Bottom = a1.y <= a2YHeight && a2YHeight <= a1YHeight

                if (a1.y == a2YHeight)
                {
                    if (a1_Left) a1.roundcorners.isTopLeft = true
                    if (a1_Right) a1.roundcorners.isTopRight = true
                    if (a2_Left) a2.roundcorners.isBottomLeft = true
                    if (a2_Right) a2.roundcorners.isBottomRight = true
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftTop = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightTop = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftBottom = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightBottom = true
                }
                if (a1.x == a2XWidth)
                {
                    if (a1_Top) a1.roundcorners.isLeftTop = true
                    if (a1_Bottom) a1.roundcorners.isLeftBottom = true
                    if (a2_Top) a2.roundcorners.isRightTop = true
                    if (a2_Bottom) a2.roundcorners.isRightBottom = true
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopLeft = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomLeft = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopRight = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomRight = true
                }
                if (a1XWidth == a2.x)
                {
                    if (a1_Top) a1.roundcorners.isRightTop = true
                    if (a1_Bottom) a1.roundcorners.isRightBottom = true
                    if (a2_Top) a2.roundcorners.isLeftTop = true
                    if (a2_Bottom) a2.roundcorners.isLeftBottom = true
                    if (a1_Top && !a2_Top) a1.roundcorners.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.roundcorners.isBottomRight = true
                    if (a2_Top && !a1_Top) a2.roundcorners.isTopLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.roundcorners.isBottomLeft = true
                }
                if (a1YHeight == a2.y)
                {
                    if (a1_Left) a1.roundcorners.isBottomLeft = true
                    if (a1_Right) a1.roundcorners.isBottomRight = true
                    if (a2_Left) a2.roundcorners.isTopLeft = true
                    if (a2_Right) a2.roundcorners.isTopRight = true
                    if (a1_Left && !a2_Left) a1.roundcorners.isLeftBottom = true
                    if (a1_Right && !a2_Right) a1.roundcorners.isRightBottom = true
                    if (a2_Left && !a1_Left) a2.roundcorners.isLeftTop = true
                    if (a2_Right && !a1_Right) a2.roundcorners.isRightTop = true
                }
            }
        }})
    }
}