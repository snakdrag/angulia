import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.notification

    implicitWidth: Math.max(_list.contentWidth, cardWidth) + space * 2
    implicitHeight: Math.max(_list.contentHeight, cardHeight) + space * 2

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
                readonly property bool haveAction: (modelData.actions.length > 0)
                implicitWidth: _.cardWidth
                implicitHeight: Math.max(_.cardHeight, _main.textHeight + _.space * 2)
                CustomRectangle {
                    property bool hovered: (false)
                    activeColor: _.textColor
                    anchors.top: parent.top
                    anchors.left: parent.left
                    radius: _.radius
                    color: _.cardColor
                    active: (
                        _.isVertical ?
                        (hovered && _main.x - _.space >= _card.width / 4 || _main.x - _.space > _card.width / 2):
                        (hovered && _main.y - _.space >= _card.height / 4 || _main.y - _.space > _card.height / 2)
                    )
                    implicitWidth: (
                        _.isVertical ?
                        Math.min(_card.width, Math.max(_main.x - _.space, _card.width / 4)):
                        _card.width
                    )
                    implicitHeight: (
                        _.isVertical ?
                        _card.height:
                        Math.min(_card.height, Math.max(_main.y - _.space, _card.height / 4))
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
                    CustomMouseArea {
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
                CustomRectangle {
                    property bool hovered: (false)
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    active: (
                        _.isVertical ?
                        (hovered && -_main.x - _.space >= _card.width / 4 || -_main.x - _.space > _card.width / 2):
                        (hovered && -_main.y - _.space >= _card.height / 4 || -_main.y - _.space > _card.height / 2)
                    )
                    implicitWidth: (
                        _.isVertical ?
                        Math.min(_card.width, Math.max(-_main.x - _.space, _card.width / 4)):
                        _card.width
                    )
                    implicitHeight: (
                        _.isVertical ?
                        _card.height:
                        Math.min(_card.height, Math.max(-_main.y - _.space, _card.height / 4))
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
                    CustomMouseArea {
                        onClicked: _card.modelData.dismiss()
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                    }
                }
                Card {
                    id: _main
                    implicitWidth: _card.width
                    implicitHeight: _card.height
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    space: _.space
                    isVertical: _.isVertical

                    imageWidth: _.imageWidth
                    imageHeight: _.imageHeight
                    imageSource: _card.modelData.image || Quickshell.iconPath(_card.modelData.appIcon, true)

                    topText: _card.modelData.summary
                    topFont: _._data.summaryFont
                    topMaximumLineCount: _card.modelData.urgency === Notifications.critical ? 0: 2

                    bottomText: _card.modelData.body
                    bottomFont: _._data.bodyFont
                    bottomMaximumLineCount: _card.modelData.urgency === Notifications.critical ? 0: 3

                    CustomMouseArea {
                        cursorShape: Qt.ArrowCursor
                        onEntered: _main.active = true
                        onExited: _main.active = false
                        onClicked: mouse => {
                        if (_.isVertical)
                        {
                            if (mouse.button === Qt.LeftButton)
                            {
                                parent.x = _card.width / 4 + _.space
                            }
                            else if (mouse.button === Qt.RightButton)
                            {
                                parent.x = -_card.width / 4 - _.space
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
                                parent.y = _card.height / 4 + _.space
                            }
                            else if (mouse.button === Qt.RightButton)
                            {
                                parent.y = -_card.height / 4 - _.space
                            }
                            else if (mouse.button === Qt.MiddleButton)
                            {
                                parent.y = 0
                            }
                        }}
                    }
                    DragHandler {
                        xAxis.enabled: _.isVertical
                        yAxis.enabled: !_.isVertical
                        onActiveChanged: {
                            if (_.isVertical)
                            {
                                if (parent.x < -_card.width / 2 - _.space)
                                {
                                    _card.modelData.dismiss()
                                }
                                else if (parent.x < -_card.width / 4)
                                {
                                    parent.x = -_card.width / 4 - _.space
                                }
                                else if (parent.x > _card.width / 2 + _.space)
                                {
                                    if (_card.haveAction)
                                    {
                                        _card.modelData.actions[0].invoke()
                                    }
                                    else {_card.modelData.dismiss()
                                    }
                                }
                                else if (parent.x > _card.width / 4)
                                {
                                    parent.x = _card.width / 4 + _.space
                                }
                                else {
                                    parent.x = 0
                                }
                            }
                            else
                            {
                                if (parent.y < -_card.height / 2 - _.space)
                                {
                                    _card.modelData.dismiss()
                                }
                                else if (parent.y < -_card.height / 4)
                                {
                                    parent.y = -_card.height / 4 - _.space
                                }
                                else if (parent.y > _card.height / 2 + _.space)
                                {
                                    if (_card.haveAction)
                                    {
                                        _card.modelData.actions[0].invoke()
                                    }
                                    else {_card.modelData.dismiss()}
                                }
                                else if (parent.y > _card.height / 4)
                                {
                                    parent.y = _card.height / 4 + _.space
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