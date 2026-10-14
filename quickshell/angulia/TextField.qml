import QtQuick
import QtQuick.Controls

TextField {
    id: _
    property int space: (0)
    property real radius: (0)
    property color backgroundColor: ("#888888")
    anchors.margins: space
    leftPadding: space
    rightPadding: space
    focus: true
    enabled: true

    placeholderText: ""
    placeholderTextColor: Qt.rgba(color.r, color.g, color.b, 0.5)

    background: Rectangle {
        radius: _.radius
        color: _.backgroundColor
    }
}