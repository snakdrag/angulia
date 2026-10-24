import QtQuick
import Quickshell.Widgets

Button {
    id: _

    property int space: (0)

    readonly property CustomItem item: (_item)
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
            asynchronous: true
            sourceSize.width: this.width
            sourceSize.height: this.height
            visible: this.status === Image.Ready && this.source != ""
            fillMode: Image.PreserveAspectFit
        }
        CustomItem {
            id: _item
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: _.space
            anchors.rightMargin: _.space
            implicitHeight: _.textHeight
            Text {
                id: _toptext
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WrapAnywhere
                elide: Text.ElideRight
            }
            Text {
                id: _bottomtext
                anchors.top: _.topText.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: _.space / 2
                wrapMode: Text.WrapAnywhere
                elide: Text.ElideRight
            }
        }
    }
}