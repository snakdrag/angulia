import QtQuick
import Quickshell
import Quickshell.Widgets
import "../components"
import "../states" as States

Panel {
    id: _

    sets: Datas.settings.popup

    customX: States.ActiveWindowManager.customX
    customY: States.ActiveWindowManager.customY

    implicitWidth: States.ActiveWindowManager.width
    implicitHeight: this.inputHeight + this.space * 3 + _list.contentHeight
    inputHeight: 30

    exclusiveZoneIgnore: false

    show: States.ActiveWindowManager.open

    Button {
        customY: parent.inputAtTop ? 0: parent.height
        anchors.margins: parent.space
        anchors.left: parent.left
        implicitWidth: parent.width / 2 - parent.space * 1.5
        implicitHeight: parent.inputHeight
        radius: parent.radius
        color: parent.cardColor
        cover.color: parent.textColor
        visible: parent.show
        Text {
            anchors.centerIn: parent
            font: _.font
            text: "fullscreen"
            color: _.textColor
        }
        onClicked: States.ActiveWindow.activeToplevel.fullscreen = true
    }
    Button {
        customY: parent.inputAtTop ? 0: parent.height
        anchors.margins: parent.space
        anchors.right: parent.right
        implicitWidth: parent.width / 2 - parent.space * 1.5
        implicitHeight: parent.inputHeight
        radius: parent.radius
        color: parent.cardColor
        cover.color: parent.textColor
        visible: parent.show
        Text {
            anchors.centerIn: parent
            font: _.font
            text: "close"
            color: _.textColor
        }
        onClicked: States.ActiveWindow.activeToplevel.close()
    }

    ClippingRectangle {
        y: Math.max(
            this.anchors.topMargin,
            Math.min(
                parent.height - this.anchors.bottomMargin - this.height,
                (parent.inputAtTop ? parent.height: 0) - this.height / 2
            )
        )
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: parent.space
        implicitWidth: parent.width - parent.space * 2
        implicitHeight: parent.height - parent.inputHeight - parent.space * 3
        radius: parent.radius
        color: parent.backgroundColor
        visible: parent.show
        List {
            id: _list
            spacing: _.space
            displaced: null
            myMode: _.myMode
            model: ScriptModel { values: _.show ? States.ActiveWindow.toplevels.values: [] }
            delegate: Item {
                required property var modelData
                implicitWidth: _main.width
                implicitHeight: _main.height
                Card {
                    id: _main
                    implicitWidth: _.width - _.space * 2
                    implicitHeight: this.textHeight + _.space * 2

                    color: _.cardColor
                    space: _.space
                    radius: _.radius

                    myMode: true

                    cover.color: _.textColor

                    topText.font.family: _.font.family
                    topText.font.pixelSize: _.font.pixelSize
                    topText.font.bold: true
                    topText.text: parent.modelData.title
                    topText.color: _.textColor
                    topText.maximumLineCount: 1

                    bottomText.font.family: _.font.family
                    bottomText.font.pixelSize: _.font.pixelSize
                    bottomText.font.bold: false
                    bottomText.text: parent.modelData.appId
                    bottomText.color: _.textColor
                    bottomText.maximumLineCount: 1

                    onClicked: {parent.modelData.activate(); States.ActiveWindowManager.close()}
                }
            }
        }
    }
}
