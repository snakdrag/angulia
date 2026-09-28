import QtQuick
import qs.angulia.theme
import "." as Custom

Custom.Item {
    anchors.fill: parent

    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property color textColor: (Colors.on_surface)
    property int edge: (Settings.edge)
    property int float: (Settings.float)
}