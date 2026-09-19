import QtQuick
import Quickshell
import "../custom" as Custom
import qs.angulia.quickshell.settings

Custom.Angulia {
    id: _
    direction: (Decorations.clockDirection % 8)

    property int clockWidth: (Decorations.clockWidth)
    property int clockHeight: (Decorations.clockHeight)
    property font clockFont: (Decorations.clockFont)
    property int space: (Decorations.notificationSpace)


    Custom.RoundRectangle {
        rectangleWidth: _.clockWidth
        rectangleHeight: _.clockHeight
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.margins: _.edge
        radius: _.radius
        color: _.color
        isTopLeft: _.isLeft
        isTopRight: _.isRight
        isLeftTop: _.isTop
        isLeftBottom: _.isBottom
        isRightTop: _.isTop
        isRightBottom: _.isBottom
        isBottomLeft: _.isLeft
        isBottomRight: _.isRight
        Text {
            anchors.centerIn: parent
            text: Qt.formatDateTime(_clock.date, "hh:mm")
            color: _.textColor
            font: _.clockFont
            SystemClock {
                id: _clock
                precision: SystemClock.Minutes
            }
        }
    }
}