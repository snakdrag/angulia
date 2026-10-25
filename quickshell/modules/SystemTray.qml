import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../components"
import "../states"

Panel {
    id: _

    customX: parent.width
    customY: parent.height

    implicitWidth: Math.max(_list.contentWidth, this.cardSize) + this.space * 2
    implicitHeight: Math.max(_list.contentHeight, this.cardSize) + this.space * 2

    property int cardSize: (30)

    iconSize: 24

    property bool myMode: (true)

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
            orientation: _.myMode ? ListView.Horizontal: ListView.Vertical
            model: ScriptModel { values: SystemTray.items.values }
            delegate: Item {
                id: _card
                required property var modelData
                implicitWidth: _main.width
                implicitHeight: _main.height
                Card {
                    id: _main
                    implicitWidth: _.cardSize
                    implicitHeight: _.cardSize
                    color: _.cardColor
                    space: _.space
                    radius: _.radius

                    myMode: _.myMode

                    cover.color: _.textColor

                    image.anchors.margins: (_.cardSize - _.iconSize) / 2
                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: parent.modelData.icon
                    image.asynchronous: false

                    onLeftClicked: {
                        parent.modelData.activate()
                        Popup.close()
                    }
                    onRightClicked: {
                        Popup.call(
                            _.x + _.space + parent.x + this.width / 2,
                            _.y + _.space + parent.y + this.height / 2,
                            parent.modelData.menu
                        )
                    }
                    onMiddleClicked: {
                        parent.modelData.secondaryActivate()
                        Popup.close()
                    }
                }
            }
        }
    }
}