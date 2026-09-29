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
        direction: _.direction
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