import QtQuick

TextInput {
    property int space: (0)
    property real radius: (0)
    property color backgroundColor: ("#888888")
    anchors.margins: this.space
    leftPadding: this.space
    rightPadding: this.space
    clip: true
    focus: true
    enabled: true

    property string placeholderText: ("")
    property color placeholderTextColor: Qt.rgba(this.color.r, this.color.g, this.color.b, 0.5)

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: parent.backgroundColor
        z: -1
    }

    Text {
        anchors.fill: parent
        topPadding: parent.topPadding
        leftPadding: parent.leftPadding
        rightPadding: parent.rightPadding
        bottomPadding: parent.bottomPadding
        font: parent.font
        text: parent.placeholderText
        color: parent.placeholderTextColor
        verticalAlignment: parent.verticalAlignment
        horizontalAlignment: parent.horizontalAlignment
        visible: parent.text === ""
    }
}