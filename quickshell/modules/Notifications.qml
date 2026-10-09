import QtQuick
import Quickshell // for Quickshell.iconPath
import Quickshell.Widgets
import "../custom" as Custom
import "../angulia"
import "../services" as Services

Custom.Angulia {
    id: _

    property int notificationCardWidth: (Custom.Data.settings.notificationCardWidth)
    property int notificationCardHeight: (Custom.Data.settings.notificationCardHeight)
    property int notificationImageSize: (Custom.Data.settings.notificationImageSize)
    property bool notificationIsVertical: (Custom.Data.settings.notificationIsVertical)
    property font notificationSummaryFont: (Custom.Data.settings.notificationSummaryFont)
    property font notificationBodyFont: (Custom.Data.settings.notificationBodyFont)
    isTop: true
    exclusionModeIgnore: false
    _contentWidth: _list.contentWidth
    _contentHeight: _list.contentHeight

    implicitWidth: noContent ? 0: Math.max(contentWidth, notificationCardWidth) + space * 2
    implicitHeight: noContent ? 0: Math.max(contentHeight, notificationCardHeight) + space * 2

    show: !noContent

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: _.backgroundColor
        Custom.ListView {
            id: _list
            spacing: _.space
            isVertical: _.notificationIsVertical
            model: Services.Notifications.server.trackedNotifications
            delegate: Item {
                id: _card
                required property var modelData
                readonly property bool haveAction: (modelData.actions.length > 0)
                implicitWidth: _.notificationCardWidth
                implicitHeight: Math.max(_.notificationCardHeight, _summary.height + _body.height + _.space * 2)
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
                Custom.Rectangle {
                    id: _clear
                    property bool hovered: (false)
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    textColor: _.textColor
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
                Custom.Rectangle {
                    id: _main
                    implicitWidth: _card.width
                    implicitHeight: _card.height
                    radius: _.radius
                    color: _.cardColor
                    textColor: _.textColor
                    active: false
                    IconImage {
                        id: _image
                        x: (
                            _.notificationIsVertical ?
                            anchors.leftMargin:
                            Math.max((parent.width - width) / 2, anchors.leftMargin)
                        )
                        y: (
                            _.notificationIsVertical ?
                            Math.max((parent.height - height) / 2, anchors.topMargin):
                            anchors.topMargin
                        )
                        anchors.margins: _.space
                        implicitSize: _.notificationImageSize
                        source: _card.modelData.image || Quickshell.iconPath(_card.modelData.appIcon, true) || ""
                        visible: status === Image.Ready && source != ""
                    }
                    Item {
                        y: (
                            _.notificationIsVertical ?
                            Math.max((parent.height - height) / 2, anchors.topMargin):
                            anchors.topMargin
                        )
                        anchors.left: parent.left
                        anchors.right: parent.right
                        implicitHeight: _body.text === "" ? _summary.height: _summary.height + _body.height
                        anchors.topMargin: _image.visible && !_.notificationIsVertical ? _image.height + _.space * 2: _.space
                        anchors.leftMargin: _image.visible && _.notificationIsVertical ? _image.width + _.space * 2: _.space
                        anchors.margins: _.space
                        Text {
                            id: _summary
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            text: _card.modelData.summary
                            color: _.textColor
                            font: _.notificationSummaryFont
                            elide: Text.ElideRight
                            wrapMode: Text.WrapAnywhere
                            maximumLineCount: _card.modelData.urgency === Services.Notifications.critical ? 0: 2
                        }
                        Text {
                            id: _body
                            anchors.top: _summary.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            text: _card.modelData.body
                            color: _.textColor
                            font: _.notificationBodyFont
                            elide: Text.ElideRight
                            wrapMode: Text.WrapAnywhere
                            maximumLineCount: _card.modelData.urgency === Services.Notifications.critical ? 0: 3
                        }
                    }
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