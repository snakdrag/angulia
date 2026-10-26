import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import "../components"
import "../states"

Panel {
    id: _

    sets: Datas.settings.notifications

    implicitWidth: this.sets.width
    implicitHeight: _list.contentHeight + this.space * 2

    show: _list.contentHeight > 0

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: parent.space
        radius: parent.radius
        color: parent.backgroundColor
        visible: parent.show
        List {
            id: _list
            spacing: _.space
            model: Notifications.trackedNotifications
            delegate: Item {
                id: _card
                required property var modelData
                readonly property bool haveAction: (this.modelData.actions.length > 0)
                function act()
                {
                    if (this.haveAction)
                    {
                        this.modelData.actions[0].invoke()
                    }
                    else {
                        this.modelData.dismiss()
                    }
                }
                implicitWidth: _.width - _.space * 2
                implicitHeight: _main.height
                Button {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    implicitWidth: Math.min(parent.width, Math.max(_main.x - _.space, parent.width / 4))
                    cover.color: _.textColor
                    color: _.cardColor
                    radius: _.radius
                    visible: _main.x > 0
                    active: this.hovered && _main.x - _.space >= parent.width / 4 || _main.x - _.space > parent.width / 2
                    onClicked: parent.act()
                    Text {
                        anchors.centerIn: parent
                        text: _card.haveAction ? "Open": "Clear"
                        color: _.textColor
                        font.family: _.font.family
                        font.pixelSize: _.font.pixelSize
                        font.bold: false
                        opacity: (_main.x - _.space - _card.width / 8) / _card.width * 8
                    }
                }
                Button {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    implicitWidth: Math.min(parent.width, Math.max(-_main.x - _.space, parent.width / 4))
                    cover.color: _.textColor
                    color: _.cardColor
                    radius: _.radius
                    visible: _main.x < 0
                    active: this.hovered && -_main.x - _.space >= parent.width / 4 || -_main.x - _.space > parent.width / 2
                    onClicked: parent.modelData.dismiss()
                    Text {
                        anchors.centerIn: parent
                        text: "Clear"
                        color: _.textColor
                        font.family: _.font.family
                        font.pixelSize: _.font.pixelSize
                        font.bold: false
                        opacity: (-_main.x - _.space - _card.width / 8) / _card.width * 8
                    }
                }
                Card {
                    id: _main
                    implicitWidth: parent.width
                    implicitHeight: (
                        this.myMode ?
                        (this.image.visible ? this.image.height + this.space: 0) + this.textHeight + this.space * 2:
                        Math.max(this.image.height, this.textHeight) + this.space * 2
                    )
                    color: _.cardColor
                    space: _.space
                    radius: _.radius

                    myMode: _.myMode

                    cover.color: _.textColor
                    cover.visible: false

                    topText.font.family: _.font.family
                    topText.font.pixelSize: _.font.pixelSize
                    topText.font.bold: true
                    topText.text: parent.modelData.summary
                    topText.color: _.textColor
                    topText.maximumLineCount: parent.modelData.urgency === Notifications.urgency.critical ? 0: 2

                    bottomText.font.family: _.font.family
                    bottomText.font.pixelSize: _.font.pixelSize
                    bottomText.font.bold: _.font.bold
                    bottomText.text: parent.modelData.body
                    bottomText.color: _.textColor
                    bottomText.maximumLineCount: parent.modelData.urgency === Notifications.urgency.critical ? 0: 4

                    image.width: _.iconSize
                    image.height: _.iconSize
                    image.source: parent.modelData.image || Quickshell.iconPath(parent.modelData.appIcon, true)

                    mouseArea.cursorShape: Qt.ArrowCursor
                    onLeftClicked: this.x = this.width / 4 + this.space
                    onRightClicked: this.x = -this.width / 4 - this.space
                    onMiddleClicked: this.x = 0

                    DragHandler {
                        xAxis.enabled: true
                        yAxis.enabled: false
                        onActiveChanged: {
                            if (parent.x < -parent.width / 2 - parent.space)
                            {
                                _card.modelData.dismiss()
                            }
                            else if (parent.x < -parent.width / 4)
                            {
                                parent.x = -parent.width / 4 - parent.space
                            }
                            else if (parent.x > parent.width / 2 + parent.space)
                            {
                                _card.act()
                            }
                            else if (parent.x > parent.width / 4)
                            {
                                parent.x = parent.width / 4 + parent.space
                            }
                            else
                            {
                                parent.x = 0
                            }
                        }
                    }
                }
            }
        }
    }
}