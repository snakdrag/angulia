import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import "../custom" as Custom
import "../services" as Services
import qs.angulia.theme

Custom.Angulia {
    id: _
    
    direction: (Settings.notificationDirection % 8)
    
    property int notificationWidth: (Settings.notificationWidth)
    property int notificationHeight: (Settings.notificationHeight)
    property color cardColor: (Colors.surface_container)
    property int space: (Settings.notificationSpace)

    property font summaryFont: (Settings.notificationSummaryFont)
    property font bodyFont: (Settings.notificationBodyFont)

    readonly property int contentHeight: (Math.min(_list.contentHeight, Screen.height / 2))

    readonly property Region region: (_region)
    Region {
        id: _region
        item: _center
    }
    Custom.RoundRectangle {
        rectangleWidth: _.contentHeight !==0 ? _.notificationWidth + _.space * 2: 0
        rectangleHeight: _.contentHeight !==0 ? _.contentHeight + _.space * 2: 0
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.margins: _.edge + _.float
        float: _.float
        radius: _.radius
        color: _.color
        isTopLeft: _.isLeft
        isTopRight: _.isRight
        isLeftTop: _.isTop
        isLeftBottom: _.isBottom
        isRightTop: _.isTop
        isRightBottom: _.isBottom
        isBottomLeft: _.isLeft
        isBottomRight: _.isRight
    }
    ClippingRectangle {
        id: _center
        implicitWidth: _.contentHeight !==0 ? _.notificationWidth: 0
        implicitHeight: _.contentHeight
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.margins: _.edge + _.space + _.float
        radius: _.radius
        color: "transparent"
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        Behavior on implicitHeight {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
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
                implicitWidth: _.notificationWidth
                implicitHeight: Math.max(_.notificationHeight, _summary.height + _body.height + _.space * 2)
                Rectangle {
                    id: _clear
                    property bool hovered: (false)
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    implicitWidth: Math.min(_.notificationWidth, Math.max(-_main.x - _.space, _.notificationWidth / 4))
                    visible: _main.x < 0
                    Text {
                        anchors.centerIn: parent
                        text: "Clear"
                        color: _.textColor
                        font: _.bodyFont
                        opacity: (-_main.x - _.space - _.notificationWidth / 8) / _.notificationWidth * 8
                    }
                    Rectangle {
                        anchors.fill: parent
                        opacity: 0.1
                        radius: _.radius
                        color: _.textColor
                        visible: (
                            -_main.x - _.space > _.notificationWidth / 2 || 
                            _clear.hovered &&
                            -_main.x - _.space >= _.notificationWidth / 4
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
                Rectangle {
                    id: _action
                    property bool hovered: (false)
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    radius: _.radius
                    color: _.cardColor
                    implicitWidth: Math.min(_.notificationWidth, Math.max(_main.x - _.space, _.notificationWidth / 4))
                    visible: _main.x > 0
                    Text {
                        anchors.centerIn: parent
                        text: _card.haveAction ? "Open": "Clear"
                        color: _.textColor
                        font: _.bodyFont
                        opacity: (_main.x - _.space - _.notificationWidth / 8) / _.notificationWidth * 8
                    }
                    Rectangle {
                        anchors.fill: parent
                        opacity: 0.1
                        radius: _.radius
                        color: _.textColor
                        visible: (
                            _main.x - _.space > _.notificationWidth / 2 || 
                            _action.hovered && 
                            _main.x - _.space >= _.notificationWidth / 4
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
                            else 
                            {
                                _card.modelData.dismiss()
                            }
                        }
                        onEntered: _action.hovered = true
                        onExited: _action.hovered = false
                    }
                }
                Rectangle {
                    id: _main
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    implicitWidth: _.notificationWidth
                    radius: _.radius
                    color: _.cardColor
                    Image {
                        id: _image
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: _.space
                        width: _.notificationWidth / 8
                        height: _.notificationWidth / 8
                        source: _card.modelData.image || _card.modelData.appIcon || ""
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
                            maximumLineCount: _card.modelData.urgency === NotificationUrgency.Critical ? undefined: 1
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
                    Behavior on x {
                        NumberAnimation { 
                            duration: 300
                            easing.type: Easing.OutCubic 
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.LeftButton) 
                            {
                                parent.x = _.notificationWidth / 4 + _.space
                            } 
                            else if (mouse.button === Qt.RightButton) 
                            {
                                parent.x = -_.notificationWidth / 4 - _.space
                            }
                            else if (mouse.button === Qt.MiddleButton) 
                            {
                                parent.x = 0
                            }
                        }
                    }
                    DragHandler {
                        xAxis.enabled: true
                        yAxis.enabled: false
                        onActiveChanged: {
                            if (parent.x < -_.notificationWidth / 2 - _.space) 
                            {
                                _card.modelData.dismiss()
                            } 
                            else if (parent.x < -_.notificationWidth / 4) 
                            {
                                parent.x = -_.notificationWidth / 4 - _.space
                            }
                            else if (parent.x > _.notificationWidth / 2 + _.space) 
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
                            else if (parent.x > _.notificationWidth / 4) 
                            {
                                parent.x = _.notificationWidth / 4 + _.space
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