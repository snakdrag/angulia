import QtQuick

TextInput {

    property real customX: (0)
    property real customY: (0)
    property int space: (0)
    property string placeholderText: ("")
    readonly property Rectangle background: (_rectangle)

    x: Math.max(this.anchors.leftMargin, Math.min(parent.width - this.anchors.rightMargin - this.width, this.customX - this.width / 2))
    y: Math.max(this.anchors.topMargin, Math.min(parent.height - this.anchors.bottomMargin - this.height, this.customY - this.height / 2))
    anchors.margins: this.space

    leftPadding: this.space
    rightPadding: this.space

    clip: true
    enabled: true
    focus: true

    verticalAlignment: TextInput.AlignVCenter

    Rectangle { id: _rectangle; anchors.fill: parent; z: -1 }
    Text {

        anchors.fill: parent

        topPadding: parent.topPadding
        leftPadding: parent.leftPadding
        rightPadding: parent.rightPadding
        bottomPadding: parent.bottomPadding

        color: parent.color
        opacity: 0.5

        font: parent.font
        text: parent.placeholderText

        verticalAlignment: parent.verticalAlignment
        horizontalAlignment: parent.horizontalAlignment

        visible: parent.text === ""
    }
}