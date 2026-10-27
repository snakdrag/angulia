import QtQuick
import Quickshell // for ScriptModel
import Quickshell.Widgets
import "../components"
import "../states" as States

Panel {
    id: _

    sets: Datas.settings.systemtray

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: Math.max(_list.contentHeight, this.cardHeight) + this.space * 2

    exclusiveZoneIgnore: true

    show: _list.contentWidth > 0 || _list.contentHeight > 0

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: parent.space
        radius: parent.radius
        color: parent.backgroundColor
        visible: parent.show
        List {
            id: _list
            spacing: _.space
            interactive: false
            myMode: _.myMode
            model: ScriptModel { values: States.SystemTray.items.values }
            delegate: Item {
                id: _card
                required property var modelData
                implicitWidth: _main.width
                implicitHeight: _main.height
                Card {
                    id: _main
                    implicitWidth: _.cardWidth
                    implicitHeight: _.cardHeight
                    color: _.cardColor
                    space: _.space
                    radius: _.radius

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