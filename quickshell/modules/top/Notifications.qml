import QtQuick
import Quickshell
import "../custom" as Custom
import qs.angulia.theme
import qs.angulia.quickshell.settings

Item {
    id: _
    anchors.fill: parent
    property int direction: (Decorations.notificationDirection % 8)
    readonly property bool isTop: (
        direction === 0 ||
        direction === 1 ||
        direction === 2
    )
    readonly property bool isLeft: (
        direction === 0 ||
        direction === 6 ||
        direction === 7
    )
    readonly property bool isRight: (
        direction === 2 ||
        direction === 3 ||
        direction === 4 
    )
    readonly property bool isBottom: (
        direction === 4 ||
        direction === 5 ||
        direction === 6 
    )

    readonly property bool isTopBottom: (
        direction === 1 ||
        direction === 5
    )
    readonly property bool isLeftRight: (
        direction === 3 ||
        direction === 7
    )

    readonly property bool isTopLeft: (
        direction === 0 ||
        direction === 1 ||
        direction === 7 
    )
    readonly property bool isTopRight: (
        direction === 1 ||
        direction === 2 ||
        direction === 3 
    )
    readonly property bool isBottomLeft: (
        direction === 5 ||
        direction === 6 ||
        direction === 7 
    )
    readonly property bool isBottomRight: (
        direction === 3 ||
        direction === 4 ||
        direction === 5 
    )
    Custom.RoundRectangle {
        rectangleWidth: Decorations.notificationWidth + Decorations.notificationSpace * 2
        rectangleHeight: Decorations.notificationHeight + Decorations.notificationSpace * 2
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.margins: Decorations.edge
        radius: Decorations.radius
        color: Colors.surface
        isTopLeft: _.isLeft
        isTopRight: _.isRight
        isLeftTop: _.isTop
        isLeftBottom: _.isBottom
        isRightTop: _.isTop
        isRightBottom: _.isBottom
        isBottomLeft: _.isLeft
        isBottomRight: _.isRight
    }
}