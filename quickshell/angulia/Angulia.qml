import QtQuick
import Quickshell // for Region
import "../../settings"

Rectangle {
    id: _

    property var _data: ({})
    readonly property var bar: (Settings.bar)
    readonly property string _itemName: ("Angulia")
    readonly property Region region: (_region)
    Region { id: _region; item: _ }

    property bool show: (true)

    property real customX: (this._data.x || 0)
    property real customY: (this._data.y || 0)

    anchors.margins: this.edge + this.float
    x: Math.max(
        this.anchors.leftMargin,
        Math.min(parent.width - this.width - this.anchors.rightMargin, this.customX - this.width / 2)
    )
    y: Math.max(
        this.anchors.topMargin,
        Math.min(parent.height - this.height - this.anchors.bottomMargin, this.customY - this.height / 2)
    )

    property bool isVertical: (this._data.isVertical || false)
    readonly property bool isTop: (y <= this.anchors.topMargin && !isVertical)
    readonly property bool isLeft: (x <= this.anchors.leftMargin && isVertical)
    readonly property bool isRight: (x + this.width >= parent.width - this.anchors.rightMargin && this.isVertical)
    readonly property bool isBottom: (y + this.height >= parent.height - this.anchors.bottomMargin && !this.isVertical)

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
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    // color
    color: Settings.colors.surface
    property color textColor: (Settings.colors.on_surface)
    property color cardColor: (Settings.colors.surface_container)
    property color backgroundColor: (Settings.colors.surface)

    // size
    property int edge: (Settings.edge)
    property int space: (Settings.space)
    property int float: (Settings.float)

    implicitWidth: this.edge
    implicitHeight: this.edge

    width: this.show ? Math.min(
        implicitWidth,
        parent.width / 2 - this.edge - this.space * 2 - (this.isTop || this.isBottom ? 0: this.float)
    ): 0
    height: this.show ? Math.min(
        implicitHeight,
        parent.height / 2 - this.edge - this.space * 2 - (this.isLeft || this.isRight ? 0: this.float)
    ): 0

    property int cardWidth: (this._data.cardWidth || 0)
    property int cardHeight: (this._data.cardHeight || 0)
    property int imageWidth: (this._data.imageWidth || this._data.iconSize || 0)
    property int imageHeight: (this._data.imageHeight || this._data.iconSize || 0)

    // radius
    radius: Settings.radius
    topLeftRadius: (this.isTopLeft || this.isLeftTop || this.forceTopLeft || this.forceLeftTop) ? 0: this.radius
    topRightRadius: (this.isTopRight || this.isRightTop || this.forceTopRight || this.forceRightTop) ? 0: this.radius
    bottomLeftRadius: (this.isBottomLeft || this.isLeftBottom || this.forceBottomLeft || this.forceLeftBottom) ? 0: this.radius
    bottomRightRadius: (this.isBottomRight || this.isRightBottom || this.forceBottomRight || this.forceRightBottom) ? 0: this.radius

    // signal
    signal positionChanged()

    // onXChanged: positionChanged()
    // onYChanged: positionChanged()
    onWidthChanged: this.positionChanged()
    onHeightChanged: this.positionChanged()
    onPositionChanged: root.check()

    signal directionChanged()

    onIsTopChanged: this.directionChanged()
    onIsLeftChanged: this.directionChanged()
    onIsRightChanged: this.directionChanged()
    onIsBottomChanged: this.directionChanged()
    onDirectionChanged: root.set()

    RoundCorners {}
}