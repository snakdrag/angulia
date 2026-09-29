import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import "../custom" as Custom
import "../services" as Services
import qs.angulia.theme

Custom.Item {
    id: _
    anchors.fill: parent
    direction: Settings.notificationDirection % 8
    
    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property color textColor: (Colors.on_surface)
    property int edge: (Settings.edge)
    property int float: (Settings.float)

    property int notificationWidth: (Settings.notificationWidth)
    property int notificationCardHeight: (Settings.notificationCardHeight)
    property color cardColor: (Colors.surface_container)
    property int space: (Settings.space)

    property font summaryFont: (Settings.notificationSummaryFont)
    property font bodyFont: (Settings.notificationBodyFont)

    anchors.margins: edge + float

    readonly property int contentHeight: (Math.min(
        _list.contentHeight,
        (
            isLeftRight ?
            parent.height / 2 - edge - space * 2:
            parent.height / 2 - edge - space * 2 - float
        )
    ))

    readonly property Region region: (_region)
    Region {
        id: _region
        item: __
    }
    Custom.Rectangle {
        id: __
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined

        implicitWidth: _.contentHeight !==0 ? _.notificationWidth: 0
        implicitHeight: _.contentHeight !==0 ? _.contentHeight + _.space * 2: 0

        float: _.float
        radius: _.radius
        color: _.color
        ClippingRectangle {
            anchors.fill: parent
            anchors.margins: _.space
            radius: _.radius
            color: "transparent"
            ListView {
                id: _list
                anchors.fill: parent
                spacing: _.space
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
                    implicitWidth: _.notificationWidth - _.space * 2
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
                            font: _.bodyFont
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
                            font: _.bodyFont
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
                                font: _.summaryFont
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
                                font: _.bodyFont
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
                            xAxis.enabled: true
                            yAxis.enabled: false
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
}