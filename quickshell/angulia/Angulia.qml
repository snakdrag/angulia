import QtQuick
import "../../settings"

Rectangle {
    id: _

    readonly property string _itemName: ("Angulia")

    property real customX: (0)
    property real customY: (0)

    x: Math.max(edge - float, Math.min(parent.width - edge - float, customX))
    y: Math.max(edge - float, Math.min(parent.height - edge - float, customY))

    property bool isVertical: (false)
    readonly property bool isTop: (y <= edge + float && !isVertical)
    readonly property bool isLeft: (x <= edge + float && isVertical)
    readonly property bool isRight: (x + implicitWidth >= parent.width - edge - float && isVertical)
    readonly property bool isBottom: (y + implicitHeight >= parent.height - edge - float && !isVertical)
    property int textRotation: (0)

    // color
    color: Settings.colors.surface
    property color textColor: (Settings.colors.on_surface)
    property color cardColor: (Settings.colors.surface_container)
    property color backgroundColor: (Settings.colors.surface)

    property int edge: (Settings.edge)
    property int float: (Settings.float)
    implicitWidth: edge
    implicitHeight: edge
    width: implicitWidth
    height: implicitHeight

    // radius
    radius: Settings.radius
    topLeftRadius: (isTopLeft || isLeftTop || forceTopLeft || forceLeftTop) ? 0: radius
    topRightRadius: (isTopRight || isRightTop || forceTopRight || forceRightTop) ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom || forceBottomLeft || forceLeftBottom) ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom || forceBottomRight || forceRightBottom) ? 0: radius

    // signal
    signal positionChanged()
    onXChanged: positionChanged()
    onYChanged: positionChanged()
    onPositionChanged: check()

    property bool isTopLeft: (false)
    property bool isTopRight: (false)
    property bool isLeftTop: (false)
    property bool isLeftBottom: (false)
    property bool isRightTop: (false)
    property bool isRightBottom: (false)
    property bool isBottomLeft: (false)
    property bool isBottomRight: (false)

    property bool forceTopLeft: (false)
    property bool forceTopRight: (false)
    property bool forceLeftTop: (false)
    property bool forceLeftBottom: (false)
    property bool forceRightTop: (false)
    property bool forceRightBottom: (false)
    property bool forceBottomLeft: (false)
    property bool forceBottomRight: (false)

    RoundCorners {}
}