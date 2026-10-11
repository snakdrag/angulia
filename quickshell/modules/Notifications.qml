import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    property var notification: (Settings.notification)
    property int notificationCardWidth: (Settings.notificationCardWidth)
    property int notificationCardHeight: (Settings.notificationCardHeight)
    property int notificationImageSize: (Settings.notificationImageSize)
    property bool notificationIsVertical: (Settings.notificationIsVertical)
    property font notificationSummaryFont: (Settings.notificationSummaryFont)
    property font notificationBodyFont: (Settings.notificationBodyFont)

    _contentWidth: _list.contentWidth
    _contentHeight: _list.contentHeight

    implicitWidth: noContent ? 0: Math.max(contentWidth, notificationCardWidth) + space * 2
    implicitHeight: noContent ? 0: Math.max(contentHeight, notificationCardHeight) + space * 2

    property Region region: (_region)
    Region { id: _region; item: _ }
    readonly property string _itemName: ("Angulia")

    show: !noContent

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: _.backgroundColor
        CustomListView {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            model: Notifications.server.trackedNotifications
            delegate: Item {
                id: _card
                required property var modelData
                readonly property bool haveAction: (modelData.actions.length > 0)
                implicitWidth: _.notificationCardWidth
                implicitHeight: Math.max(_.notificationCardHeight, _main.textHeight + _.space * 2)
                CustomRectangle {
                    id: _action
                    property bool hovered: (false)
                    activeColor: _.textColor
                    anchors.top: parent.top
                    anchors.left: parent.left
                    radius: _.radius
                    color: _.cardColor
                    active: (
                        _.notificationIsVertical ?
                        (_action.hovered && _main.x - _.space >= _card.width / 4 || _main.x - _.space > _card.width / 2):
                        (_action.hovered && _main.y - _.space >= _card.height / 4 || _main.y - _.space > _card.height / 2)
                    )
                    implicitWidth: (
                        _.notificationIsVertical ?
                        Math.min(_card.width, Math.max(_main.x - _.space, _card.width / 4)):
                        _card.width
                    )
                    implicitHeight: (
                        _.notificationIsVertical ?
                        _card.height:
                        Math.min(_card.height, Math.max(_main.y - _.space, _card.height / 4))
                    )
                    visible: _.notificationIsVertical ? -_main.x < 0: -_main.y < 0
                    Text {
                        anchors.centerIn: parent
                        text: _card.haveAction ? "Open": "Clear"
                        color: _.textColor
                        font: _.notificationBodyFont
                        opacity: (
                            _.notificationIsVertical ?
                            ((_main.x - _.space - _card.width / 8) / _card.width * 8):
                            ((_main.y - _.space - _card.height / 8) / _card.height * 8)
                        )
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (_card.haveAction)
                            {
                                _card.modelData.actions[0].invoke()
                            }
                            else {
                                _card.modelData.dismiss()
                            }
                        }
                        onEntered: _action.hovered = true
                        onExited: _action.hovered = false
                    }
                }
                CustomRectangle {
                    id: _clear
                    property bool hovered: (false)
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    active: (
                        _.notificationIsVertical ?
                        ( _clear.hovered && -_main.x - _.space >= _card.width / 4 || -_main.x - _.space > _card.width / 2):
                        ( _clear.hovered && -_main.y - _.space >= _card.height / 4 || -_main.y - _.space > _card.height / 2)
                    )
                    implicitWidth: (
                        _.notificationIsVertical ?
                        Math.min(_card.width, Math.max(-_main.x - _.space, _card.width / 4)):
                        _card.width
                    )
                    implicitHeight: (
                        _.notificationIsVertical ?
                        _card.height:
                        Math.min(_card.height, Math.max(-_main.y - _.space, _card.height / 4))
                    )
                    visible: _.notificationIsVertical ? _main.x < 0: _main.y < 0
                    Text {
                        anchors.centerIn: parent
                        text: "Clear"
                        color: _.textColor
                        font: _.notificationBodyFont
                        opacity: (
                            _.notificationIsVertical ?
                            ((-_main.x - _.space - _card.width / 8) / _card.width * 8):
                            ((-_main.y - _.space - _card.height / 8) / _card.height * 8)
                        )
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: _card.modelData.dismiss()
                        onEntered: _clear.hovered = true
                        onExited: _clear.hovered = false
                    }
                }
                Card {
                    id: _main
                    implicitWidth: _card.width
                    implicitHeight: _card.height
                    radius: _.radius
                    color: _.cardColor
                    activeColor: _.textColor
                    active: false
                    space: _.space
                    isVertical: _.isVertical

                    iconSize: notification.iconSize
                    iconSource: _card.modelData.image || Quickshell.iconPath(_card.modelData.appIcon, true)

                    topText: _card.modelData.summary
                    topFont: _.notificationSummaryFont
                    topMaximumLineCount: _card.modelData.urgency === Notifications.critical ? 0: 2

                    bottomText: _card.modelData.body
                    bottomFont: _.notificationBodyFont
                    bottomMaximumLineCount: _card.modelData.urgency === Notifications.critical ? 0: 3

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        onEntered: _main.active = true
                        onExited: _main.active = false
                        onClicked: mouse => {
                        if (_.notificationIsVertical)
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
                        xAxis.enabled: _.notificationIsVertical
                        yAxis.enabled: !_.notificationIsVertical
                        onActiveChanged: {
                            if (_.notificationIsVertical)
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