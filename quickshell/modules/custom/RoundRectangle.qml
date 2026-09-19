import QtQuick
import Quickshell

Item {
    id: _

    property int rectangleWidth: (100)
    property int rectangleHeight: (100)
    property real radius: (0)
    property color color: ("#ffffff")
    property bool isTopLeft: (false)
    property bool isTopRight: (false)
    property bool isLeftTop: (false)
    property bool isLeftBottom: (false)
    property bool isRightTop: (false)
    property bool isRightBottom: (false)
    property bool isBottomLeft: (false)
    property bool isBottomRight: (false)

    property bool isTop: (!isTopLeft && !isTopRight || anchors.top === parent.top)
    property bool isLeft: (!isLeftTop && !isLeftBottom || anchors.left === parent.left)
    property bool isRight: (!isRightTop && !isRightBottom || anchors.right === parent.right)
    property bool isBottom: (!isBottomLeft && !isBottomRight || anchors.bottom === parent.bottom)

    implicitWidth: (
        isLeft || isRight ? (
            isLeft && isRight ? 
            rectangleWidth: 
            rectangleWidth + radius
        ): rectangleWidth + radius * 2
    )
    implicitHeight: (
        isTop || isBottom ? (
            isTop && isBottom ? 
            rectangleHeight: 
            rectangleHeight + radius
        ): rectangleHeight + radius * 2
    )
    readonly property Region region: (_region)
    Region {
        id: _region
        item: __
    }
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    Rectangle {
        id: __
        anchors.fill: parent
        anchors.topMargin: _.isTop ? 0: _.radius
        anchors.leftMargin: _.isLeft ? 0: _.radius
        anchors.rightMargin: _.isRight ? 0: _.radius
        anchors.bottomMargin: _.isBottom ? 0: _.radius
        topLeftRadius: _.isTopLeft || _.isLeftTop ? 0: _.radius
        topRightRadius: _.isTopRight || _.isRightTop ? 0: _.radius
        bottomLeftRadius: _.isBottomLeft || _.isLeftBottom ? 0: _.radius
        bottomRightRadius: _.isBottomRight || _.isRightBottom ? 0: _.radius
        color: _.color
    }
    RoundCorner {
        anchors.left: __.left
        anchors.bottom: __.top
        radius: Math.min(_.radius, _.rectangleWidth / 2)
        color: _.color
        visible: _.isTopLeft && !_.isTop && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 270
    }
    RoundCorner {
        anchors.right: __.right
        anchors.bottom: __.top
        radius: Math.min(_.radius, _.rectangleWidth / 2)
        color: _.color
        visible: _.isTopRight && !_.isTop && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: __.top
        anchors.right: __.left
        radius: Math.min(_.radius, _.rectangleHeight / 2)
        color: _.color
        visible: _.isLeftTop && !_.isLeft && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: __.bottom
        anchors.right: __.left
        radius: Math.min(_.radius, _.rectangleHeight / 2)
        color: _.color
        visible: _.isLeftBottom && !_.isLeft && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 180
    }
    RoundCorner {
        anchors.top: __.top
        anchors.left: __.right
        radius: Math.min(_.radius, _.rectangleHeight / 2)
        color: _.color
        visible: _.isRightTop && !_.isRight && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: __.bottom
        anchors.left: __.right
        radius: Math.min(_.radius, _.rectangleHeight / 2)
        color: _.color
        visible: _.isRightBottom && !_.isRight && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 270
    }
    RoundCorner {
        anchors.top: __.bottom
        anchors.left: __.left
        radius: Math.min(_.radius, _.rectangleWidth / 2)
        color: _.color
        visible: _.isBottomLeft && !_.isBottom && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 0
    }
    RoundCorner {
        anchors.top: __.bottom
        anchors.right: __.right
        radius: Math.min(_.radius, _.rectangleWidth / 2)
        color: _.color
        visible: _.isBottomRight && !_.isBottom && rectangleHeight !== 0 && rectangleWidth !== 0
        rotation: 90
    }
}