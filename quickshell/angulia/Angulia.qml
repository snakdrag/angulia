import QtQuick
import Quickshell // for Region
import "../../settings"

Rectangle {
    id: _

    property var _data: ({})
    readonly property var bar: (Settings.bar)
    readonly property Region region: (_region)
    Region { id: _region; item: _ }

    property bool show: (true)

    property real customX: (this._data.x || 0)
    property real customY: (this._data.y || 0)

    property bool exclusiveZoneIgnore: (this._data.exclusiveZoneIgnore === undefined ? true: this._data.exclusiveZoneIgnore)

    anchors.margins: this.edge + this.float
    anchors.topMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.topExclusiveZone + this.float
    anchors.leftMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.leftExclusiveZone + this.float
    anchors.rightMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.rightExclusiveZone + this.float
    anchors.bottomMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.bottomExclusiveZone + this.float

    x: Math.max(
        this.anchors.leftMargin,
        Math.min(parent.width - this.width - this.anchors.rightMargin, this.customX - this.width / 2)
    )
    y: Math.max(
        this.anchors.topMargin,
        Math.min(parent.height - this.height - this.anchors.bottomMargin, this.customY - this.height / 2)
    )

    property bool isVertical: (this._data.isVertical || false)
    readonly property bool isTop: (
        this.exclusiveZoneIgnore &&
        this.visible &&
        y <= this.anchors.topMargin &&
        !this.isVertical
    )
    readonly property bool isLeft: (
        this.exclusiveZoneIgnore &&
        this.visible &&
        x <= this.anchors.leftMargin &&
        this.isVertical
    )
    readonly property bool isRight: (
        this.exclusiveZoneIgnore &&
        this.visible &&
        x + this.width >= parent.width - this.anchors.rightMargin &&
        this.isVertical
    )
    readonly property bool isBottom: (
        this.exclusiveZoneIgnore &&
        this.visible &&
        y + this.height >= parent.height - this.anchors.bottomMargin &&
        !this.isVertical
    )

    // behavior
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    // color
    color: Settings.colors.surface
    property color textColor: (Settings.colors.on_surface)
    property color cardColor: (Settings.colors.surface_container)
    property color backgroundColor: (this.color)

    // size
    property int gaps_out: (Settings.gaps_out)
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
    property bool noTopLeftRadius: (false)
    property bool noTopRightRadius: (false)
    property bool noBottomLeftRadius: (false)
    property bool noBottomRightRadius: (false)

    topLeftRadius: (
        this.roundcorners.isTopLeft ||
        this.roundcorners.isLeftTop ||
        this.roundcorners.forceTopLeft ||
        this.roundcorners.forceLeftTop ||
        this.noTopLeftRadius
    ) ? 0: this.radius
    topRightRadius: (
        this.roundcorners.isTopRight ||
        this.roundcorners.isRightTop ||
        this.roundcorners.forceTopRight ||
        this.roundcorners.forceRightTop ||
        this.noTopRightRadius
    ) ? 0: this.radius
    bottomLeftRadius: (
        this.roundcorners.isBottomLeft ||
        this.roundcorners.isLeftBottom ||
        this.roundcorners.forceBottomLeft ||
        this.roundcorners.forceLeftBottom ||
        this.noBottomLeftRadius
    ) ? 0: this.radius
    bottomRightRadius: (
        this.roundcorners.isBottomRight ||
        this.roundcorners.isRightBottom ||
        this.roundcorners.forceBottomRight ||
        this.roundcorners.forceRightBottom ||
        this.noBottomRightRadius
    ) ? 0: this.radius

    // signal
    signal positionChanged()

    onXChanged: this.positionChanged()
    onYChanged: this.positionChanged()
    onWidthChanged: this.positionChanged()
    onHeightChanged: this.positionChanged()
    onPositionChanged: root.check()

    signal directionChanged()

    onIsTopChanged: this.directionChanged()
    onIsLeftChanged: this.directionChanged()
    onIsRightChanged: this.directionChanged()
    onIsBottomChanged: this.directionChanged()
    onDirectionChanged: root.set()

    RoundCorners { id: _roundcorners }
    property RoundCorners roundcorners: (_roundcorners)
}