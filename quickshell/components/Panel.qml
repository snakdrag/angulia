import QtQuick
import Quickshell // for Region
import "../custom"

CustomRectangle {
    id: _

    property var sets: ({})
    property bool myMode: (this.sets.myMode || false)
    property int edge: (Datas.settings.edge)
    property int float: (Datas.settings.float)
    property int space: (Datas.settings.space)
    property int iconSize: (this.sets.iconSize || 0)
    property int cardWidth: (this.sets.cardWidth || 0)
    property int cardHeight: (this.sets.cardHeight || 0)
    property bool inputAtTop: (this.sets.inputAtTop || false)
    property int inputHeight: (this.sets.inputHeight || 0)
    property color textColor: (Datas.colors.on_surface)
    property color cardColor: (Datas.colors.surface_container)
    property color backgroundColor: ("transparent")
    property font font: (this.sets.font || {family: "Inter", pixelSize: 12, bold: false, })
    property bool exclusiveZoneIgnore: (this.sets.exclusiveZoneIgnore || false)
    property bool isVertical: (this.sets.isVertical || false)
    property bool isHorizontal: (this.sets.isHorizontal || false)
    property bool show: (true)
    property int maxWidth: (parent.width / 2)
    property int maxHeight: (parent.height / 2)
    readonly property Region region: (_region)
    readonly property RoundCorners roundcorners: (_roundcorners)
    readonly property bool isTop: (this.isHorizontal && this.y <= this.anchors.topMargin)
    readonly property bool isLeft: (this.isVertical && this.x <= this.anchors.leftMargin)
    readonly property bool isRight: (this.isVertical && this.x + this.width >= parent.width - this.anchors.rightMargin)
    readonly property bool isBottom: (this.isHorizontal && this.y + this.height >= parent.height - this.anchors.bottomMargin)
    readonly property var exclusiveZones: ({
        top: (this.exclusiveZoneIgnore && this.visible && this.isTop ? this.anchors.topMargin + this.height: 0),
        left: (this.exclusiveZoneIgnore && this.visible && this.isLeft ? this.anchors.leftMargin + this.width: 0),
        right: (this.exclusiveZoneIgnore && this.visible && this.isRight ? this.anchors.rightMargin + this.width: 0),
        bottom: (this.exclusiveZoneIgnore && this.visible && this.isBottom ? this.anchors.bottomMargin + this.height: 0),
    })

    customX: this.sets.x || 0
    customY: this.sets.y || 0
    anchors.margins: this.edge + this.float
    anchors.topMargin: this.exclusiveZoneIgnore ? this.anchors.margins: ExclusiveZones.top + this.float
    anchors.leftMargin: this.exclusiveZoneIgnore ? this.anchors.margins: ExclusiveZones.left + this.float
    anchors.rightMargin: this.exclusiveZoneIgnore ? this.anchors.margins: ExclusiveZones.right + this.float
    anchors.bottomMargin: this.exclusiveZoneIgnore ? this.anchors.margins: ExclusiveZones.bottom + this.float
    implicitWidth: this.edge
    implicitHeight: this.edge
    width: this.show ? Math.min(this.implicitWidth, this.maxWidth): 0
    height: this.show ? Math.min(this.implicitHeight, this.maxHeight): 0

    color: Datas.colors.surface

    radius: Datas.settings.radius
    topLeftRadius: this.roundcorners.isTopLeft || this.roundcorners.isLeftTop ? 0: this.radius
    topRightRadius: this.roundcorners.isTopRight || this.roundcorners.isRightTop ? 0: this.radius
    bottomLeftRadius: this.roundcorners.isBottomLeft || this.roundcorners.isLeftBottom ? 0: this.radius
    bottomRightRadius: this.roundcorners.isBottomRight || this.roundcorners.isRightBottom ? 0: this.radius

    Behavior on width { CustomNumberAnimation { onRunningChanged: {root.check(); ExclusiveZones.set()} } }
    Behavior on height { CustomNumberAnimation { onRunningChanged: {root.check(); ExclusiveZones.set()} } }

    Region { id: _region; item: _ }
    RoundCorners { id: _roundcorners }

    onXChanged: root.check()
    onYChanged: root.check()
    onFloatChanged: ExclusiveZones.set()
    onIsTopChanged: ExclusiveZones.set()
    onIsLeftChanged: ExclusiveZones.set()
    onIsRightChanged: ExclusiveZones.set()
    onIsBottomChanged: ExclusiveZones.set()
}