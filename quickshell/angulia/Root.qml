import QtQuick
import Quickshell
import "../../settings"

ShellRoot {
    id: _

    Component.onCompleted: {check(); set()}

    readonly property var bar: (Settings.bar)
    property list<Item> modules: ([])

    property bool _top: (false)
    property bool _left: (false)
    property bool _right: (false)
    property bool _bottom: (false)
    function set()
    {
        Qt.callLater(() => {
        _top = false
        _left = false
        _right = false
        _bottom = false
        for (let i = 0; i < modules.length; i++) {
            _top = _top || modules[i].isTop
            _left = _left || modules[i].isLeft
            _right = _right || modules[i].isRight
            _bottom = _bottom || modules[i].isBottom
        }})
    }

    property int gaps_out: (Settings.gaps_out)
    property int exclusiveZones: (Settings.edge)
    property int topExclusiveZone: (exclusiveZones + (_top ? Settings.float + bar.height: 0))
    property int leftExclusiveZone: (exclusiveZones + (_left ? Settings.float + bar.width: 0))
    property int rightExclusiveZone: (exclusiveZones + (_right ? Settings.float + bar.width: 0))
    property int bottomExclusiveZone: (exclusiveZones + (_bottom ? Settings.float + bar.height: 0))

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

    property list<Item> childrens: ([])
    function check()
    {
        Qt.callLater(() => {anguliaCheck(Settings.radius)})
    }
    function anguliaCheck(radius)
    {
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

                let a1_Top = a2.y - a1.y <= radius && a1.y - a2YHeight <= radius
                let a1_Left = a2.x - a1.x <= radius && a1.x - a2XWidth <= radius
                let a1_Right = a2.x - a1XWidth <= radius && a1XWidth - a2XWidth <= radius
                let a1_Bottom = a2.y - a1YHeight <= radius && a1YHeight - a2YHeight <= radius
                let a2_Top = a1.y - a2.y <= radius && a2.y - a1YHeight <= radius
                let a2_Left = a1.x - a2.x <= radius && a2.x - a1XWidth <= radius
                let a2_Right = a1.x - a2XWidth <= radius && a2XWidth - a1XWidth <= radius
                let a2_Bottom = a1.y - a2YHeight <= radius && a2YHeight - a1YHeight <= radius

                if (-radius <= (a1.y - a2YHeight) && (a1.y - a2YHeight) <= 0)
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
                if (-radius <= (a1.x - a2XWidth) && (a1.x - a2XWidth) <= 0)
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
                if (0 <= (a1XWidth - a2.x) && (a1XWidth - a2.x) <= radius)
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
                if (0 <= (a1YHeight - a2.y) && (a1YHeight - a2.y) <= radius)
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
        }
    }
}