import QtQuick

TextInput {

    property string placeholderText: ("")

    clip: true
    focus: true
    enabled: true

    verticalAlignment: TextInput.AlignVCenter

    property real customX: (0)
    property real customY: (0)

    x: Math.max(this.anchors.leftMargin, Math.min(parent.width - this.anchors.rightMargin - this.width, this.customX - this.width / 2))
    y: Math.max(this.anchors.topMargin, Math.min(parent.height - this.anchors.bottomMargin - this.height, this.customY - this.height / 2))

    property int space: (0)

    anchors.margins: this.space
    leftPadding: this.space
    rightPadding: this.space

    Rectangle { id: _rectangle; anchors.fill: parent; z: -1 }
    property Rectangle background: (_rectangle)

    Text {
        anchors.fill: parent

        topPadding: parent.topPadding
        leftPadding: parent.leftPadding
        rightPadding: parent.rightPadding
        bottomPadding: parent.bottomPadding

        text: parent.placeholderText
        font: parent.font
        color: parent.color
        opacity: 0.5

        verticalAlignment: parent.verticalAlignment
        horizontalAlignment: parent.horizontalAlignment
        visible: parent.text === ""
    }
}