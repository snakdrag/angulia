import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.notification

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: Math.max(_list.contentHeight, this.cardHeight) + this.space * 2

    exclusiveZoneIgnore: false
    show: _list.contentWidth !== 0 && _list.contentHeight !== 0

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: _.backgroundColor
        List {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            model: Notifications.server.trackedNotifications
            delegate: Item {
                id: _card
                required property var modelData
                readonly property bool haveAction: (this.modelData.actions.length > 0)
                implicitWidth: _.cardWidth
                implicitHeight: Math.max(_.cardHeight, _main.textHeight + _.space * 2)
                Button {
                    property bool hovered: (false)
                    activeColor: _.textColor
                    anchors.top: parent.top
                    anchors.left: parent.left
                    radius: _.radius
                    color: _.cardColor
                    active: (
                        _.isVertical ?
                        (this.hovered && _main.x - _.space >= parent.width / 4 || _main.x - _.space > parent.width / 2):
                        (this.hovered && _main.y - _.space >= parent.height / 4 || _main.y - _.space > parent.height / 2)
                    )
                    implicitWidth: (
                        _.isVertical ?
                        Math.min(parent.width, Math.max(_main.x - _.space, parent.width / 4)):
                        parent.width
                    )
                    implicitHeight: (
                        _.isVertical ?
                        parent.height:
                        Math.min(parent.height, Math.max(_main.y - _.space, parent.height / 4))
                    )
                    visible: _.isVertical ? -_main.x < 0: -_main.y < 0
                    Text {
                        anchors.centerIn: parent
                        text: _card.haveAction ? "Open": "Clear"
                        color: _.textColor
                        font: _._data.bodyFont
                        opacity: (
                            _.isVertical ?
                            ((_main.x - _.space - _card.width / 8) / _card.width * 8):
                            ((_main.y - _.space - _card.height / 8) / _card.height * 8)
                        )
                    }
                    mouseArea.onClicked: {
                        if (parent.haveAction)
                        {
                            parent.modelData.actions[0].invoke()
                        }
                        else
                        {
                            parent.modelData.dismiss()
                        }
                    }
                    mouseArea.onEntered: this.hovered = true
                    mouseArea.onExited: this.hovered = false
                }
                Button {
                    property bool hovered: (false)
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    active: (
                        _.isVertical ?
                        (this.hovered && -_main.x - _.space >= parent.width / 4 || -_main.x - _.space > parent.width / 2):
                        (this.hovered && -_main.y - _.space >= parent.height / 4 || -_main.y - _.space > parent.height / 2)
                    )
                    implicitWidth: (
                        _.isVertical ?
                        Math.min(parent.width, Math.max(-_main.x - _.space, parent.width / 4)):
                        parent.width
                    )
                    implicitHeight: (
                        _.isVertical ?
                        parent.height:
                        Math.min(parent.height, Math.max(-_main.y - _.space, parent.height / 4))
                    )
                    visible: _.isVertical ? _main.x < 0: _main.y < 0
                    Text {
                        anchors.centerIn: parent
                        text: "Clear"
                        color: _.textColor
                        font: _._data.bodyFont
                        opacity: (
                            _.isVertical ?
                            ((-_main.x - _.space - _card.width / 8) / _card.width * 8):
                            ((-_main.y - _.space - _card.height / 8) / _card.height * 8)
                        )
                    }
                    mouseArea.onClicked: parent.modelData.dismiss()
                    mouseArea.onEntered: this.hovered = true
                    mouseArea.onExited: this.hovered = false
                }
                Card {
                    id: _main
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    space: _.space
                    isVertical: _.isVertical

                    imageWidth: _.imageWidth
                    imageHeight: _.imageHeight
                    imageSource: parent.modelData.image || Quickshell.iconPath(parent.modelData.appIcon, true)

                    topText: parent.modelData.summary
                    topFont: _._data.summaryFont
                    topMaximumLineCount: parent.modelData.urgency === Notifications.critical ? 0: 2

                    bottomText: parent.modelData.body
                    bottomFont: _._data.bodyFont
                    bottomMaximumLineCount: parent.modelData.urgency === Notifications.critical ? 0: 3

                    mouseArea.cursorShape: Qt.ArrowCursor
                    mouseArea.onEntered: this.active = true
                    mouseArea.onExited: this.active = false
                    mouseArea.onClicked: mouse => {
                    let place = 0
                    if (mouse.button === Qt.LeftButton) place = (this.isVertical ? this.width: this.height) / 4 + this.space
                    if (mouse.button === Qt.RightButton) place = -(this.isVertical ? this.width: this.height) / 4 - this.space
                    if (this.isVertical) this.x = place
                    else this.y = place
                    }
                    DragHandler {
                        xAxis.enabled: parent.isVertical
                        yAxis.enabled: !parent.isVertical
                        onActiveChanged: {
                            let place = parent.isVertical ? parent.x: parent.y
                            let size = parent.isVertical ? parent.width: parent.height
                            if (place < -size / 2 - parent.space)
                            {
                                _card.modelData.dismiss()
                            }
                            else if (place < -size / 4)
                            {
                                place = -size / 4 - parent.space
                            }
                            else if (place > size / 2 + parent.space)
                            {
                                if (_card.haveAction)
                                {
                                    _card.modelData.actions[0].invoke()
                                }
                                else
                                {
                                    _card.modelData.dismiss()
                                }
                            }
                            else if (place > size / 4)
                            {
                                place = size / 4 + parent.space
                            }
                            else
                            {
                                place = 0
                            }
                            if (parent.isVertical)
                            {
                                parent.x = place
                            }
                            else
                            {
                                parent.y = place
                            }
                        }
                    }
                }
            }
        }
    }
}