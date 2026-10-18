import QtQuick
import Quickshell.Widgets

Button {
    id: _
    property bool isVertical: (false)
    property bool centerIn: (false)
    property int space: (0)

    property bool asynchronous: (true)

    property int imageWidth: (0)
    property int imageHeight: (0)
    property string imageSource: ("")
    property int imageFillMode: (Image.PreserveAspectFit)

    property string topText: ("")
    property int topMaximumLineCount: (0)
    property font topFont: ({ family: "Inter", bold: true, })

    property string bottomText: ("")
    property int bottomMaximumLineCount: (0)
    property font bottomFont: ({ family: "Inter", bold: false, })

    property int horizontalAlignment: (this.isVertical ? Text.AlignLeft: Text.AlignHCenter)

    Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    readonly property int textHeight: (_top.height + (_bottom.text === "" ? 0: _bottom.height + _.space / 2))

    ClippingRectangle {
        anchors.fill: parent

        topLeftRadius: parent.topLeftRadius
        topRightRadius: parent.topRightRadius
        bottomLeftRadius: parent.bottomLeftRadius
        bottomRightRadius: parent.bottomRightRadius

        color: "transparent"

        Image {
            id: _image
            x: (
                _.isVertical && !_.centerIn ?
                (this.anchors.leftMargin):
                ((parent.width - this.width) / 2)
            )
            y: (
                _.isVertical || _.centerIn ?
                ((parent.height - this.height) / 2):
                (this.anchors.topMargin)
            )
            anchors.margins: _.space
            width: _.imageWidth
            height: _.imageHeight
            asynchronous: _.asynchronous
            sourceSize.width: _.imageWidth
            sourceSize.height: _.imageHeight
            source: _.imageSource || ""
            fillMode: _.imageFillMode
            visible: this.status === Image.Ready && this.source != ""
        }
        Item {
            y: (
                _.isVertical ?
                Math.max((parent.height - this.height) / 2, this.anchors.topMargin):
                this.anchors.topMargin
            )
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: _bottom.text === "" ? _top.height: _top.height + _bottom.height + _.space / 2
            anchors.topMargin: _image.visible && !_.isVertical ? _image.height + _.space * 2: _.space
            anchors.leftMargin: _image.visible && _.isVertical ? _image.width + _.space * 2: _.space
            anchors.margins: _.space
            Text {
                id: _top
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                text: _.topText
                font: _.topFont
                color: _.activeColor
                elide: Text.ElideRight
                horizontalAlignment: _.horizontalAlignment
                wrapMode: _.isVertical ? Text.WrapAnywhere: Text.NoWrap
                maximumLineCount: _.topMaximumLineCount
            }
            Text {
                id: _bottom
                anchors.top: _top.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: _.space / 2
                text: _.bottomText
                font: _.bottomFont
                color: _.activeColor
                elide: Text.ElideRight
                horizontalAlignment: _.horizontalAlignment
                wrapMode: Text.WrapAnywhere
                maximumLineCount: _.bottomMaximumLineCount
            }
        }
    }
}