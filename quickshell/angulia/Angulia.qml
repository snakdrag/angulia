import QtQuick
import Quickshell // for Region
import "../../settings"

Rectangle {
    id: _

    readonly property string _itemName: ("Angulia")
    readonly property Region region: (_region)
    Region { id: _region; item: _ }

    property bool show: (true)

    property real customX: (0)
    property real customY: (0)

    anchors.margins: edge + float
    x: Math.max(anchors.leftMargin, Math.min(parent.width - implicitWidth - anchors.rightMargin, customX - implicitWidth / 2))
    y: Math.max(anchors.topMargin, Math.min(parent.height - implicitHeight - anchors.bottomMargin, customY - implicitHeight / 2))

    property bool isVertical: (false)
    readonly property bool isTop: (y <= anchors.topMargin && !isVertical)
    readonly property bool isLeft: (x <= anchors.leftMargin && isVertical)
    readonly property bool isRight: (x + implicitWidth >= parent.width - anchors.rightMargin && isVertical)
    readonly property bool isBottom: (y + implicitHeight >= parent.height - anchors.bottomMargin && !isVertical)
    property int textRotation: (0)

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

    // behavior
    // Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    // Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    // color
    color: Settings.colors.surface
    property color textColor: (Settings.colors.on_surface)
    property color cardColor: (Settings.colors.surface_container)
    property color backgroundColor: (Settings.colors.surface)

    // size
    property int edge: (Settings.edge)
    property int space: (Settings.space)
    property int float: (Settings.float)
    implicitWidth: show ? edge: 0
    implicitHeight: show ? edge: 0
    width: implicitWidth
    height: implicitHeight
    property int cardWidth: (edge)
    property int cardHeight: (edge)
    property int iconSize: (edge)

    // content
    property int _contentWidth: (0)
    property int _contentHeight: (0)
    readonly property int contentWidth: (
        Math.min(_contentWidth, parent.width / 2 - edge - space * 2 - (isTop || isBottom ? 0: float))
    )
    readonly property int contentHeight: (
        Math.min(_contentHeight, parent.height / 2 - edge - space * 2 - (isLeft || isRight ? 0: float))
    )
    readonly property bool noContent: (contentWidth === 0 || contentHeight === 0)

    // radius
    radius: Settings.radius
    topLeftRadius: (isTopLeft || isLeftTop || forceTopLeft || forceLeftTop) ? 0: radius
    topRightRadius: (isTopRight || isRightTop || forceTopRight || forceRightTop) ? 0: radius
    bottomLeftRadius: (isBottomLeft || isLeftBottom || forceBottomLeft || forceLeftBottom) ? 0: radius
    bottomRightRadius: (isBottomRight || isRightBottom || forceBottomRight || forceRightBottom) ? 0: radius

    // signal
    signal positionChanged()
    // onXChanged: positionChanged()
    // onYChanged: positionChanged()
    onImplicitWidthChanged: positionChanged()
    onImplicitHeightChanged: positionChanged()
    onPositionChanged: {check(); set()}

    RoundCorners {}
}