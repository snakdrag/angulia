import QtQuick
import QtQuick.Layouts
import Quickshell
import "bar" as Bar
import "../custom" as Custom
import qs.angulia.theme

Custom.Rectangle {
    id: _
    direction: (Settings.barDirection % 8)

    property int barWidth: (Settings.barWidth)
    property int barHeight: (Settings.barHeight)

    property int edge: (Settings.edge)

    radius: Settings.radius
    color: Colors.surface
    float: Settings.float

    anchors.margins: edge + float

    implicitWidth: barWidth
    implicitHeight: barHeight

    RowLayout {
        anchors.fill: parent
        Bar.Space {}
        Bar.Clock {}
        Bar.Space {}
    }
}
