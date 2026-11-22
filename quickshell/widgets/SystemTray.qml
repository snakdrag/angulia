import QtQuick
import Quickshell
import "../components"
import "../states" as States

ClippingRectangle {

    property int space: (parent.space || 0)
    property int iconSize: (parent.iconSize || 0)
    property int cardWidth: (parent.cardWidth || 0)
    property int cardHeight: (parent.cardHeight || 0)
    property color textColor: (parent.textColor || "#ffffff")
    property bool myMode: (parent.myMode || false)
    readonly property int contentWidth: (_list.contentWidth)
    readonly property int contentHeight: (_list.contentHeight)

    color: "transparent"
    radius: parent.radius

    List {
        id: _list

        interactive: false
        myMode: _.myMode

        model: ScriptModel { values: States.SystemTray.items.values }
        delegate: Item {
            id: _card

            required property var modelData

            implicitWidth: _.cardWidth
            implicitHeight: _.cardHeight

            Button {

                anchors.fill: parent

                color: "transparent"
                radius: _.radius

                onLeftClicked: parent.modelData.activate()
                onRightClicked: States.Popup.call(
                    _.x + _.space + parent.x + this.width / 2,
                    _.y + _.space + parent.y + this.height / 2,
                    parent.modelData.menu
                )
                onMiddleClicked: parent.modelData.secondaryActivate()

                cover.color: _.textColor

                Image {
                    id: _image

                    anchors.centerIn: parent
                    width: _.iconSize
                    height: _.iconSize
                    sourceSize.width: this.width
                    sourceSize.height: this.height

                    fillMode: Image.PreserveAspectFit
                    source: _card.modelData.icon

                    visible: this.status === Image.Ready && this.source != ""
                }
            }
        }
    }
}