import QtQuick
import QtQuick.Controls

TextInput {
    id: _
    property int space: (0)
    property real radius: (0)
    property color backgroundColor: ("#888888")
    anchors.margins: space
    leftPadding: space
    rightPadding: space
    clip: true
    focus: true
    enabled: true

    property string placeholderText: ("")
    property color placeholderTextColor: Qt.rgba(color.r, color.g, color.b, 0.5)

    Rectangle {
        anchors.fill: parent
        radius: _.radius
        color: _.backgroundColor
        z: -1
    }
    Text {
        anchors.fill: parent
        leftPadding: _.space
        rightPadding: _.space
        text: _.placeholderText
        color: _.placeholderTextColor
        verticalAlignment: _.verticalAlignment
        horizontalAlignment: _.horizontalAlignment
        visible: _.text === ""
    }
}