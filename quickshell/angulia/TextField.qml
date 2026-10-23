import QtQuick

TextInput {
    property int space: (0)
    property Rectangle background: (_rectangle)
    property string placeholderText: ("")

    anchors.margins: this.space
    leftPadding: this.space
    rightPadding: this.space

    clip: true
    focus: true
    enabled: true

    Rectangle {
        id: _rectangle
        anchors.fill: parent
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
        color: parent.color
        opacity: 0.5

        verticalAlignment: parent.verticalAlignment
        horizontalAlignment: parent.horizontalAlignment
        visible: parent.text === ""
    }
}