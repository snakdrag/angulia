import QtQuick
import Quickshell
import "../components"
import "../states" as States

Panel {
    id: _

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: Math.max(_list.contentHeight, this.cardHeight) + this.space * 2

    exclusiveZoneIgnore: true
    sets: Datas.settings.systemtray
    show: _list.contentWidth > 0 || _list.contentHeight > 0

    ClippingRectangle {

        anchors.fill: parent
        anchors.margins: parent.space

        color: parent.backgroundColor
        radius: parent.radius

        List {
            id: _list

            interactive: false
            myMode: _.myMode
            spacing: _.space

            model: ScriptModel { values: States.SystemTray.items.values }
            delegate: Item {

                required property var modelData

                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight

                Card {

                    anchors.fill: parent

                    color: _.cardColor
                    radius: _.radius

                    space: _.space
                    myMode: _.myMode

                    cover.color: _.textColor

                    image.anchors.margins: 0
                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.customX: this.width / 2
                    image.customY: this.height / 2
                    image.source: parent.modelData.icon
                    image.asynchronous: false

                    onLeftClicked: parent.modelData.activate()
                    onRightClicked: States.Popup.call(
                        _.x + _.space + parent.x + this.width / 2,
                        _.y + _.space + parent.y + this.height / 2,
                        parent.modelData.menu
                    )
                    onMiddleClicked: parent.modelData.secondaryActivate()
                }
            }
        }
    }
}