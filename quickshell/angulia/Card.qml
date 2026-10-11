import QtQuick

CustomRectangle {
    id: _
    property bool isVertical: (false)
    property int space: (0)

    property int iconSize: (0)
    property string iconSource: ("")

    property string topText: ("")
    property int topMaximumLineCount: (0)
    property font topFont: ({ family: "Inter", bold: true, })

    property string bottomText: ("")
    property int bottomMaximumLineCount: (0)
    property font bottomFont: ({ family: "Inter", bold: false, })

    property int horizontalAlignment: (isVertical ? Text.AlignLeft: Text.AlignHCenter)

    Behavior on x { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    readonly property int textHeight: (_top.height + _bottom.height + _.space / 2)

    Image {
        id: _image
        x: (
            _.isVertical ?
            anchors.leftMargin:
            Math.max((parent.width - width) / 2, anchors.leftMargin)
        )
        y: (
            _.isVertical ?
            Math.max((parent.height - height) / 2, anchors.topMargin):
            anchors.topMargin
        )
        anchors.margins: _.space
        width: _.iconSize
        height: _.iconSize
        source: iconSource || ""
        fillMode: Image.PreserveAspectFit
        visible: status === Image.Ready && source != ""
    }
    Item {
        y: (
            _.isVertical ?
            Math.max((parent.height - height) / 2, anchors.topMargin):
            anchors.topMargin
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