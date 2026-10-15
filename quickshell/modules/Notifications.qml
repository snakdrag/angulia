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
                    Mouse {
                        onClicked: {
                            if (_card.haveAction)
                            {
                                _card.modelData.actions[0].invoke()
                            }
                            else
                            {
                                _card.modelData.dismiss()
                            }
                        }
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                    }
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
                    Mouse {
                        onClicked: _card.modelData.dismiss()
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                    }
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

                    Mouse {
                        cursorShape: Qt.ArrowCursor
                        onEntered: parent.active = true
                        onExited: parent.active = false
                        onClicked: mouse => {
                        if (parent.isVertical)
                        {
                            if (mouse.button === Qt.LeftButton)
                            {
                                parent.x = parent.width / 4 + parent.space
                            }
                            else if (mouse.button === Qt.RightButton)
                            {
                                parent.x = -parent.width / 4 - parent.space
                            }
                            else if (mouse.button === Qt.MiddleButton)
                            {
                                parent.x = 0
                            }
                        }
                        else
                        {
                            if (mouse.button === Qt.LeftButton)
                            {
                                parent.y = parent.height / 4 + parent.space
                            }
                            else if (mouse.button === Qt.RightButton)
                            {
                                parent.y = -parent.height / 4 - parent.space
                            }
                            else if (mouse.button === Qt.MiddleButton)
                            {
                                parent.y = 0
                            }
                        }}
                    }
                    DragHandler {
                        xAxis.enabled: parent.isVertical
                        yAxis.enabled: !parent.isVertical
                        onActiveChanged: {
                            if (parent.isVertical)
                            {
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
                                    if (_card.haveAction)
                                    {
                                        _card.modelData.actions[0].invoke()
                                    }
                                    else {_card.modelData.dismiss()
                                    }
                                }
                                else if (parent.x > parent.width / 4)
                                {
                                    parent.x = parent.width / 4 + parent.space
                                }
                                else {
                                    parent.x = 0
                                }
                            }
                            else
                            {
                                if (parent.y < -parent.height / 2 - parent.space)
                                {
                                    _card.modelData.dismiss()
                                }
                                else if (parent.y < -parent.height / 4)
                                {
                                    parent.y = -parent.height / 4 - parent.space
                                }
                                else if (parent.y > parent.height / 2 + parent.space)
                                {
                                    if (_card.haveAction)
                                    {
                                        _card.modelData.actions[0].invoke()
                                    }
                                    else {_card.modelData.dismiss()}
                                }
                                else if (parent.y > parent.height / 4)
                                {
                                    parent.y = parent.height / 4 + parent.space
                                }
                                else
                                {
                                    parent.y = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}