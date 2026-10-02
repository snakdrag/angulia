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
            parent.width / 2 - edge - space:
            parent.width / 2 - edge - space - float
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

    implicitWidth: contentHeight !==0 && contentWidth !== 0 ? Math.max(contentWidth, notificationCardWidth) + space * 2: 0
    implicitHeight: contentHeight !==0 && contentWidth !== 0 ? Math.max(contentHeight, notificationCardHeight) + space * 2: 0

    show: contentHeight !== 0

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        radius: _.radius
        color: "transparent"
        ListView {
            id: _list
            anchors.fill: parent
            spacing: _.space
            orientation: _.notificationIsVertical ? ListView.Vertical: ListView.Horizontal
            model: Services.Notifications.server.trackedNotifications
            displaced: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
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
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    implicitWidth: Math.min(_card.width, Math.max(_main.x - _.space, _card.width / 4))
                    visible: -_main.x < 0
                    Text {
                        anchors.centerIn: parent
                        text: _card.haveAction ? "Open": "Clear"
                        color: _.textColor
                        font: _.notificationBodyFont
                        opacity: (_main.x - _.space - _card.width / 8) / _card.width * 8
                    }
                    Custom.Cover {
                        show: (
                            _action.hovered &&
                            _main.x - _.space >= _card.width / 4 ||
                            _main.x - _.space > _card.width / 2
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
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    implicitWidth: Math.min(_card.width, Math.max(-_main.x - _.space, _card.width / 4))
                    visible: _main.x < 0
                    Text {
                        anchors.centerIn: parent
                        text: "Clear"
                        color: _.textColor
                        font: _.notificationBodyFont
                        opacity: (-_main.x - _.space - _card.width / 8) / _card.width * 8
                    }
                    Custom.Cover {
                        show: (
                            _clear.hovered &&
                            -_main.x - _.space >= _card.width / 4 ||
                            -_main.x - _.space > _card.width / 2
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
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    implicitWidth: parent.width
                    radius: _.radius
                    color: _.cardColor
                    Behavior on x {
                        NumberAnimation { 
                            duration: 300
                            easing.type: Easing.OutCubic 
                        }
                    }
                    Image {
                        id: _image
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: _.space
                        width: _.notificationCardHeight - _.space * 2
                        height: _.notificationCardHeight - _.space * 2
                        source: _card.modelData.image || Quickshell.iconPath(_card.modelData.appIcon, true) || ""
                        fillMode: Image.PreserveAspectFit
                        visible: status === Image.Ready && source != ""
                    }
                    Item {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        implicitHeight: _body.text !== "" ? _summary.height + _body.height: _summary.height
                        anchors.leftMargin: _image.visible ? _image.width + _.space * 2: _.space
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
                            maximumLineCount: _card.modelData.urgency === NotificationUrgency.Critical ? undefined: 2
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
                            maximumLineCount: _card.modelData.urgency === NotificationUrgency.Critical ? undefined: 3
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.LeftButton) {parent.x = _card.width / 4 + _.space} 
                            else if (mouse.button === Qt.RightButton) {parent.x = -_card.width / 4 - _.space}
                            else if (mouse.button === Qt.MiddleButton) {parent.x = 0}
                        }
                    }
                    DragHandler {
                        xAxis.enabled: _.notificationIsVertical
                        yAxis.enabled: !_.notificationIsVertical
                        onActiveChanged: {
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
                    }
                }
            }
        }
    }
}