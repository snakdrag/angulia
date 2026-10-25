import QtQuick
import Quickshell // for Region

CustomRectangle {
    id: _

    property var sets: ({})

    radius: Datas.settings.radius
    property int edge: (Datas.settings.edge)
    property int float: (Datas.settings.float)
    property int space: (Datas.settings.space)
    property int iconSize: (40)

    property int cardWidth: (320)
    property int cardHeight: (180)

    color: Datas.colors.surface
    property color textColor: (Datas.colors.on_surface)
    property color cardColor: (Datas.colors.surface_container)
    property color backgroundColor: ("transparent")
    property font font: ({
        family: "Inter",
        pixelSize: 12
    })

    property bool exclusiveZoneIgnore: (true)

    property bool isVertical: (false)
    property bool isHorizontal: (true)

    readonly property bool isTop: (y <= this.anchors.topMargin && this.exclusiveZoneIgnore && this.visible && this.isHorizontal)
    readonly property bool isLeft: (x <= this.anchors.leftMargin && this.exclusiveZoneIgnore && this.visible && this.isVertical)
    readonly property bool isRight: (
        x + this.width >= parent.width - this.anchors.rightMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isVertical
    )
    readonly property bool isBottom: (
        y + this.height >= parent.height - this.anchors.bottomMargin &&
        this.exclusiveZoneIgnore && this.visible && this.isHorizontal
    )

    property var exclusiveZones: ({
        top: (this.isTop ? this.edge + this.float + this.height: 0),
        left: (this.isLeft ? this.edge + this.float + this.width: 0),
        right: (this.isRight ? this.edge + this.float + this.width: 0),
        bottom: (this.isBottom ? this.edge + this.float + this.height: 0),
    })

    anchors.margins: this.edge + this.float
    anchors.topMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.topExclusiveZone + this.float
    anchors.leftMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.leftExclusiveZone + this.float
    anchors.rightMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.rightExclusiveZone + this.float
    anchors.bottomMargin: this.exclusiveZoneIgnore ? this.anchors.margins: root.bottomExclusiveZone + this.float

    property bool show: (true)

    property int maxWidth: (parent.width / 2)
    property int maxHeight: (parent.height / 2)

    implicitWidth: this.edge
    implicitHeight: this.edge

    width: this.show ? Math.min(this.implicitWidth, this.maxWidth): 0
    height: this.show ? Math.min(this.implicitHeight, this.maxHeight): 0

    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

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

    onXChanged: root.check()
    onYChanged: root.check()
    onWidthChanged: root.set()
    onHeightChanged: root.set()
}