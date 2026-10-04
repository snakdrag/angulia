import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import "../custom" as Custom
import "../services" as Services

Custom.Rectangle {
    id: _

    readonly property int contentWidth: (Math.min(
        _list.contentWidth,
        (
            _IsTopBottom ?
            parent.width / 2 - edge - space * 2:
            parent.width / 2 - edge - space * 2 - float
        )
    ))
    readonly property int contentHeight: (Math.min(
        _list.contentHeight,
        (
            _IsLeftRight ?
            parent.height / 2 - edge - space * 2:
            parent.height / 2 - edge - space * 2 - float
        )
    ))

    implicitWidth: contentHeight ===0 || contentWidth === 0 ? 0: Math.max(contentWidth, notificationCardWidth) + space * 2
    implicitHeight: contentHeight ===0 || contentWidth === 0 ? 0: Math.max(contentHeight, notificationCardHeight) + space * 2

    show: !(contentHeight ===0 || contentWidth === 0
)
    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: _.backgroundColor
        ListView {
            id: _list
            anchors.fill: parent
            spacing: _.space
            orientation: _.notificationIsVertical ? ListView.Vertical: ListView.Horizontal
            model: Services.Notifications.server.trackedNotifications
            displaced: Transition { Custom.NA { properties: "x, y" } }
            delegate: Item {
                id: _card
                required property var modelData
                readonly property bool haveAction: (modelData.actions.length > 0)
                implicitWidth: _.notificationCardWidth
                implicitHeight: Math.max(_.notificationCardHeight, _summary.height + _body.height + _.space * 2)
                Rectangle {
                    id: _action
                    property bool hovered: (false)
                    anchors.top: parent.top
                    anchors.left: parent.left
                    radius: _.radius
                    color: _.cardColor
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
                            (_main.x - _.space - _card.width / 8) / _card.width * 8:
                            (_main.y - _.space - _card.height / 8) / _card.height * 8
                        )
                    }
                    Custom.Cover {
                        show: (
                            _.notificationIsVertical ?
                            (
                                _action.hovered &&
                                _main.x - _.space >= _card.width / 4 ||
                                _main.x - _.space > _card.width / 2
                            ):
                            (
                                _action.hovered &&
                                _main.y - _.space >= _card.height / 4 ||
                                _main.y - _.space > _card.height / 2
                            )
                        )
                        color: _.textColor
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (_card.haveAction) {_card.modelData.actions[0].invoke()}
                            else {_card.modelData.dismiss()}
                        }
                        onEntered: _action.hovered = true
                        onExited: _action.hovered = false
                    }
                }
                Rectangle {
                    id: _clear
                    property bool hovered: (false)
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
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
                            (-_main.x - _.space - _card.width / 8) / _card.width * 8:
                            (-_main.y - _.space - _card.height / 8) / _card.height * 8
                        )
                    }
                    Custom.Cover {
                        show: (
                            _.notificationIsVertical ?
                            (
                                _clear.hovered &&
                                -_main.x - _.space >= _card.width / 4 ||
                                -_main.x - _.space > _card.width / 2
                            ):
                            (
                                _clear.hovered &&
                                -_main.y - _.space >= _card.height / 4 ||
                                -_main.y - _.space > _card.height / 2
                            )
                        )
                        color: _.textColor
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
                Rectangle {
                    id: _main
                    property bool hovered: (false)
                    implicitWidth: _card.width
                    implicitHeight: _card.height
                    radius: _.radius
                    color: _.cardColor
                    Behavior on x { Custom.NA {} }
                    Behavior on y { Custom.NA {} }
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
                            maximumLineCount: _card.modelData.urgency === NotificationUrgency.Critical ? 0: 2
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
                            maximumLineCount: _card.modelData.urgency === NotificationUrgency.Critical ? 0: 3
                        }
                    }
                    Custom.Cover {
                        show: _main.hovered
                        color: _.textColor
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        onEntered: _main.hovered = true
                        onExited: _main.hovered = false
                        onClicked: mouse => {
                            if (_.notificationIsVertical)
                            {
                                if (mouse.button === Qt.LeftButton) {parent.x = _card.width / 4 + _.space} 
                                else if (mouse.button === Qt.RightButton) {parent.x = -_card.width / 4 - _.space}
                                else if (mouse.button === Qt.MiddleButton) {parent.x = 0}
                            }
                            else
                            {
                                if (mouse.button === Qt.LeftButton) {parent.y = _card.height / 4 + _.space} 
                                else if (mouse.button === Qt.RightButton) {parent.y = -_card.height / 4 - _.space}
                                else if (mouse.button === Qt.MiddleButton) {parent.y = 0}
                            }
                        }
                    }
                    DragHandler {
                        xAxis.enabled: _.notificationIsVertical
                        yAxis.enabled: !_.notificationIsVertical
                        onActiveChanged: {
                            if (_.notificationIsVertical)
                            {
                                if (parent.x < -_card.width / 2 - _.space) {_card.modelData.dismiss()} 
                                else if (parent.x < -_card.width / 4) {parent.x = -_card.width / 4 - _.space}
                                else if (parent.x > _card.width / 2 + _.space) 
                                {
                                    if (_card.haveAction)
                                    {_card.modelData.actions[0].invoke()}
                                    else {_card.modelData.dismiss()}
                                }
                                else if (parent.x > _card.width / 4) 
                                {parent.x = _card.width / 4 + _.space}
                                else {parent.x = 0}
                            }
                            else
                            {
                                if (parent.y < -_card.height / 2 - _.space) {_card.modelData.dismiss()} 
                                else if (parent.y < -_card.height / 4) {parent.y = -_card.height / 4 - _.space}
                                else if (parent.y > _card.height / 2 + _.space) 
                                {
                                    if (_card.haveAction)
                                    {_card.modelData.actions[0].invoke()}
                                    else {_card.modelData.dismiss()}
                                }
                                else if (parent.y > _card.height / 4) 
                                {parent.y = _card.height / 4 + _.space}
                                else {parent.y = 0}
                            }
                        }
                    }
                }
            }
        }
    }
}