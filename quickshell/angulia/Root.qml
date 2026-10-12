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

    readonly property int topExclusiveZone: (
        Settings.gaps_out + Settings.edge +
        (_top ? Settings.float + Settings.bar.height: 0)
    )
    readonly property int leftExclusiveZone: (
        Settings.gaps_out + Settings.edge +
        (_left ? Settings.float + Settings.bar.width: 0)
    )
    readonly property int rightExclusiveZone: (
        Settings.gaps_out + Settings.edge +
        (_right ? Settings.float + Settings.bar.width: 0)
    )
    readonly property int bottomExclusiveZone: (
        Settings.gaps_out + Settings.edge +
        (_bottom ? Settings.float + Settings.bar.height: 0)
    )
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

    function set()
    {
        Qt.callLater(() => {
        let angulia = []
        for (let i = 0; i < modules.length; i++) {
            let module = modules[i]
            if (module && module._itemName === "Angulia")
            {
                angulia.push(module)
            }
        }
        _top = false
        _left = false
        _right = false
        _bottom = false
        for (let i = 0; i < angulia.length; i++) {
            _top = _top || angulia[i].isTop
            _left = _left || angulia[i].isLeft
            _right = _right || angulia[i].isRight
            _bottom = _bottom || angulia[i].isBottom
        }})
    }
    function check()
    {
        Qt.callLater(() => {
        let tolerance = 0
        let angulia = []
        for (let i = 0; i < childrens.length; i++) {
            let child = childrens[i]
            if (child && child._itemName === "Angulia")
            {
                angulia.push(child)
                child.isTopLeft = false
                child.isTopRight = false
                child.isLeftTop = false
                child.isLeftBottom = false
                child.isRightTop = false
                child.isRightBottom = false
                child.isBottomLeft = false
                child.isBottomRight = false
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

                let a1_Top = a2.y - a1.y <= tolerance && a1.y - a2YHeight <= tolerance
                let a1_Left = a2.x - a1.x <= tolerance && a1.x - a2XWidth <= tolerance
                let a1_Right = a2.x - a1XWidth <= tolerance && a1XWidth - a2XWidth <= tolerance
                let a1_Bottom = a2.y - a1YHeight <= tolerance && a1YHeight - a2YHeight <= tolerance
                let a2_Top = a1.y - a2.y <= tolerance && a2.y - a1YHeight <= tolerance
                let a2_Left = a1.x - a2.x <= tolerance && a2.x - a1XWidth <= tolerance
                let a2_Right = a1.x - a2XWidth <= tolerance && a2XWidth - a1XWidth <= tolerance
                let a2_Bottom = a1.y - a2YHeight <= tolerance && a2YHeight - a1YHeight <= tolerance

                if (-tolerance * 2 <= (a1.y - a2YHeight) && (a1.y - a2YHeight) <= 0)
                {
                    if (a1_Left) a1.isTopLeft = true
                    if (a1_Right) a1.isTopRight = true
                    if (a2_Left) a2.isBottomLeft = true
                    if (a2_Right) a2.isBottomRight = true
                    if (a1_Left && !a2_Left) a1.isLeftTop = true
                    if (a1_Right && !a2_Right) a1.isRightTop = true
                    if (a2_Left && !a1_Left) a2.isLeftBottom = true
                    if (a2_Right && !a1_Right) a2.isRightBottom = true
                }
                if (-tolerance * 2 <= (a1.x - a2XWidth) && (a1.x - a2XWidth) <= 0)
                {
                    if (a1_Top) a1.isLeftTop = true
                    if (a1_Bottom) a1.isLeftBottom = true
                    if (a2_Top) a2.isRightTop = true
                    if (a2_Bottom) a2.isRightBottom = true
                    if (a1_Top && !a2_Top) a1.isTopLeft = true
                    if (a1_Bottom && !a2_Bottom) a1.isBottomLeft = true
                    if (a2_Top && !a1_Top) a2.isTopRight = true
                    if (a2_Bottom && !a1_Bottom) a2.isBottomRight = true
                }
                if (0 <= (a1XWidth - a2.x) && (a1XWidth - a2.x) <= tolerance * 2)
                {
                    if (a1_Top) a1.isRightTop = true
                    if (a1_Bottom) a1.isRightBottom = true
                    if (a2_Top) a2.isLeftTop = true
                    if (a2_Bottom) a2.isLeftBottom = true
                    if (a1_Top && !a2_Top) a1.isTopRight = true
                    if (a1_Bottom && !a2_Bottom) a1.isBottomRight = true
                    if (a2_Top && !a1_Top) a2.isTopLeft = true
                    if (a2_Bottom && !a1_Bottom) a2.isBottomLeft = true
                }
                if (0 <= (a1YHeight - a2.y) && (a1YHeight - a2.y) <= tolerance * 2)
                {
                    if (a1_Left) a1.isBottomLeft = true
                    if (a1_Right) a1.isBottomRight = true
                    if (a2_Left) a2.isTopLeft = true
                    if (a2_Right) a2.isTopRight = true
                    if (a1_Left && !a2_Left) a1.isLeftBottom = true
                    if (a1_Right && !a2_Right) a1.isRightBottom = true
                    if (a2_Left && !a1_Left) a2.isLeftTop = true
                    if (a2_Right && !a1_Right) a2.isRightTop = true
                }
            }
        }})
    }
}