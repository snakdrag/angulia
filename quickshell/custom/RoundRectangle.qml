import QtQuick

Item {
    id: _

    property int rectangleWidth: (0)
    property int rectangleHeight: (0)
    property real radius: (0)
    property color color: ("#ffffff")

    property bool float: (false)

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

    readonly property Rectangle rectangle: (__)

    implicitWidth: (
        isLeft || isRight ? (
            isLeft && isRight ? 
            rectangleWidth: 
            rectangleWidth + radius
        ): rectangleWidth + radius * 2
    )
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    implicitHeight: (
        isTop || isBottom ? (
            isTop && isBottom ? 
            rectangleHeight: 
            rectangleHeight + radius
        ): rectangleHeight + radius * 2
    )
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
        topLeftRadius: _.isTopLeft || _.isLeftTop && !_.float ? 0: _.radius
        topRightRadius: _.isTopRight || _.isRightTop && !_.float ? 0: _.radius
        bottomLeftRadius: _.isBottomLeft || _.isLeftBottom && !_.float ? 0: _.radius
        bottomRightRadius: _.isBottomRight || _.isRightBottom && !_.float ? 0: _.radius
        color: _.color
    }
    RoundCorner {
        anchors.left: __.left
        anchors.bottom: __.top
        radius: Math.min(_.radius, __.width / 2)
        color: _.color
        visible: _.isTopLeft && !_.isTop && !_.float
        rotation: 270
    }
    RoundCorner {
        anchors.right: __.right
        anchors.bottom: __.top
        radius: Math.min(_.radius, __.width / 2)
        color: _.color
        visible: _.isTopRight && !_.isTop && !_.float
        rotation: 180
    }
    RoundCorner {
        anchors.top: __.top
        anchors.right: __.left
        radius: Math.min(_.radius, __.height / 2)
        color: _.color
        visible: _.isLeftTop && !_.isLeft && !_.float
        rotation: 90
    }
    RoundCorner {
        anchors.bottom: __.bottom
        anchors.right: __.left
        radius: Math.min(_.radius, __.height / 2)
        color: _.color
        visible: _.isLeftBottom && !_.isLeft && !_.float
        rotation: 180
    }
    RoundCorner {
        anchors.top: __.top
        anchors.left: __.right
        radius: Math.min(_.radius, __.height / 2)
        color: _.color
        visible: _.isRightTop && !_.isRight && !_.float
        rotation: 0
    }
    RoundCorner {
        anchors.bottom: __.bottom
        anchors.left: __.right
        radius: Math.min(_.radius, __.height / 2)
        color: _.color
        visible: _.isRightBottom && !_.isRight && !_.float
        rotation: 270
    }
    RoundCorner {
        anchors.top: __.bottom
        anchors.left: __.left
        radius: Math.min(_.radius, __.width / 2)
        color: _.color
        visible: _.isBottomLeft && !_.isBottom && !_.float
        rotation: 0
    }
    RoundCorner {
        anchors.top: __.bottom
        anchors.right: __.right
        radius: Math.min(_.radius, __.width / 2)
        color: _.color
        visible: _.isBottomRight && !_.isBottom && !_.float
        rotation: 90
    }
}