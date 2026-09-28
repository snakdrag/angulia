import QtQuick
import QtQuick.Layouts
import Quickshell
import "bar" as Bar
import "../custom" as Custom
import qs.angulia.theme

Custom.Angulia {
    id: _
    anchors.fill: parent
    direction: (Settings.barDirection % 8)

    property int barWidth: (Settings.barWidth)
    property int barHeight: (Settings.barHeight)

    anchors.margins: _.edge + _.float

    Custom.Rectangle {
        implicitWidth: _.barWidth
        implicitHeight: _.barHeight
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        float: _.float
        radius: _.radius
        color: _.color
        RowLayout {
            anchors.fill: parent
            Bar.Space {}
            Bar.Clock {}
            Bar.Space {}
        }
    }
}