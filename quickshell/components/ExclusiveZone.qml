import QtQuick
import Quickshell

PanelWindow {

    property bool top: (false)
    property bool left: (false)
    property bool right: (false)
    property bool bottom: (false)

    anchors.top: this.top
    anchors.left: this.left
    anchors.right: this.right
    anchors.bottom: this.bottom

    implicitWidth: 0
    implicitHeight: 0

    Behavior on exclusiveZone { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
}