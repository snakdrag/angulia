import QtQuick
import Quickshell.Widgets
import "../custom"

Button {
    id: _

    property int space: (0)
    property bool myMode: (true)
    readonly property CustomImage image: (_image)
    readonly property Text topText: (_toptext)
    readonly property Text bottomText: (_bottomtext)
    readonly property int textHeight: (this.topText.height + (this.bottomText.text === "" ? 0: this.bottomText.height + this.bottomText.anchors.topMargin))

    Behavior on x { CustomNumberAnimation {} }
    Behavior on y { CustomNumberAnimation {} }

    ClippingRectangle {

        anchors.fill: parent

        color: "transparent"

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        CustomImage {
            id: _image

            customY: _.myMode ? 0: parent.height / 2
            customX: _.myMode ? parent.width / 2: 0
            anchors.margins: _.space
            sourceSize.width: this.width
            sourceSize.height: this.height

            asynchronous: true
            fillMode: Image.PreserveAspectFit

            visible: this.status === Image.Ready && this.source != ""
        }
        CustomItem {

            customY: parent.height / 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: _.space
            anchors.topMargin: this.anchors.margins + (_.image.visible && _.myMode ? _.image.height + _.space: 0)
            anchors.leftMargin: this.anchors.margins + (_.image.visible && !_.myMode ? _.image.width + _.space: 0)
            implicitHeight: _.textHeight

            Text {
                id: _toptext

                width: parent.width

                elide: Text.ElideRight
                wrapMode: Text.WrapAnywhere

                horizontalAlignment: _.myMode ? Text.AlignHCenter: Text.AlignLeft
            }
            Text {
                id: _bottomtext

                anchors.top: _toptext.bottom
                anchors.topMargin: _.space
                width: parent.width

                elide: Text.ElideRight
                wrapMode: Text.WrapAnywhere

                horizontalAlignment: _.myMode ? Text.AlignHCenter: Text.AlignLeft
            }
        }
    }
}