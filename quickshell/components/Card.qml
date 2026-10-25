import QtQuick
import Quickshell.Widgets

Button {
    id: _

    property int space: (0)

    property bool myMode: (true)

    readonly property CustomImage image: (_image)
    readonly property Text topText: (_toptext)
    readonly property Text bottomText: (_bottomtext)

    readonly property int textHeight: (this.topText.height + (this.bottomText.text === "" ? 0: this.bottomText.height + _.space / 2))

    ClippingRectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        color: "transparent"

        CustomImage {
            id: _image
            customY: _.myMode ? 0: parent.height / 2
            customX: _.myMode ? parent.width / 2: 0
            anchors.margins: _.space
            asynchronous: true
            sourceSize.width: this.width
            sourceSize.height: this.height
            visible: this.status === Image.Ready && this.source != ""
            fillMode: Image.PreserveAspectFit
        }
        Item {
            y: Math.max(
                this.anchors.topMargin,
                Math.min(
                    parent.height - this.anchors.bottomMargin - this.height,
                    parent.height / 2 - this.height / 2
                )
            )
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: _.image.visible && _.myMode ? _.image.height + _.space * 2: _.space
            anchors.leftMargin: _.image.visible && !_.myMode ? _.image.width + _.space * 2: _.space
            anchors.rightMargin: _.space
            anchors.bottomMargin: _.space
            implicitHeight: _.textHeight
            Text {
                id: _toptext
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WrapAnywhere
                elide: Text.ElideRight
                horizontalAlignment: _.myMode ? Text.AlignHCenter: Text.AlignLeft
            }
            Text {
                id: _bottomtext
                anchors.top: _.topText.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: _.space / 2
                wrapMode: Text.WrapAnywhere
                elide: Text.ElideRight
                horizontalAlignment: _.myMode ? Text.AlignHCenter: Text.AlignLeft
            }
        }
    }
}