import QtQuick
import Quickshell // for Region

CustomRectangle {

    id: _

    property bool exclusiveZoneIgnore: (true)

    property bool isVertical: (false)
    property bool isHorizontal: (true)

    readonly property bool isTop: (
        y <= this.anchors.topMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isHorizontal
    )
    readonly property bool isLeft: (
        x <= this.anchors.leftMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isVertical
    )
    readonly property bool isRight: (
        x + this.width >= parent.width - this.anchors.rightMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isVertical
    )
    readonly property bool isBottom: (
        y + this.height >= parent.height - this.anchors.bottomMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isHorizontal
    )

    property var exclusiveZones: ({
        top: (this.isTop ? this.height: 0),
        left: (this.isLeft ? this.width: 0),
        right: (this.isRight ? this.width: 0),
        bottom: (this.isBottom ? this.height: 0),
    })

    property bool show: (true)

    property int maxWidth: (parent.width / 2)
    property int maxHeight: (parent.height / 2)

    width: this.show ? Math.min(this.implicitWidth, this.maxWidth): 0
    height: this.show ? Math.min(this.implicitHeight, this.maxHeight): 0

    color: "#000000"

    topLeftRadius: (
        this.roundcorners.isTopLeft ||
        this.roundcorners.isLeftTop ||
        this.roundcorners.forceTopLeft ||
        this.roundcorners.forceLeftTop
    ) ? 0: this.radius
    topRightRadius: (
        this.roundcorners.isTopRight ||
        this.roundcorners.isRightTop ||
        this.roundcorners.forceTopRight ||
        this.roundcorners.forceRightTop
    ) ? 0: this.radius
    bottomLeftRadius: (
        this.roundcorners.isBottomLeft ||
        this.roundcorners.isLeftBottom ||
        this.roundcorners.forceBottomLeft ||
        this.roundcorners.forceLeftBottom
    ) ? 0: this.radius
    bottomRightRadius: (
        this.roundcorners.isBottomRight ||
        this.roundcorners.isRightBottom ||
        this.roundcorners.forceBottomRight ||
        this.roundcorners.forceRightBottom
    ) ? 0: this.radius

    Region { id: _region; item: _ }
    property Region region: (_region)

    RoundCorners { id: _roundcorners }
    property RoundCorners roundcorners: (_roundcorners)
}