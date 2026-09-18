import QtQuick
import Quickshell
import Quickshell.Widgets
import "../custom" as Custom
import "../services" as Services
import qs.angulia.theme
import qs.angulia.quickshell.settings

Item {
    id: _
    anchors.fill: parent
    property int direction: (Decorations.notificationDirection % 8)
    
    readonly property bool isTop: ( direction === 0 || direction === 1 || direction === 2 )
    readonly property bool isLeft: ( direction === 0 || direction === 6 || direction === 7 )
    readonly property bool isRight: ( direction === 2 || direction === 3 || direction === 4 )
    readonly property bool isBottom: ( direction === 4 || direction === 5 || direction === 6 )

    readonly property bool isTopBottom: ( direction === 1 || direction === 5 )
    readonly property bool isLeftRight: ( direction === 3 || direction === 7 )

    readonly property bool isTopLeft: ( direction === 0 || direction === 1 || direction === 7 )
    readonly property bool isTopRight: ( direction === 1 || direction === 2 || direction === 3 )
    readonly property bool isBottomLeft: ( direction === 5 || direction === 6 || direction === 7 )
    readonly property bool isBottomRight: ( direction === 3 || direction === 4 || direction === 5 )

    property int notificationWidth: (Decorations.notificationWidth)
    property int notificationHeight: (Decorations.notificationHeight)
    property int edge: (Decorations.edge)
    property color cardColor: (Colors.surface_container)
    property color textColor: (Colors.on_surface)
    property real radius: (Decorations.radius)
    property int space: (Decorations.notificationSpace)

    property font summaryFont: (Decorations.notificationSummaryFont)
    property font bodyFont: (Decorations.notificationBodyFont)

    readonly property int contentHeight: (Math.min(_list.contentHeight, Screen.height / 2))

    readonly property Region region: (_region)
    Region {
        id: _region
        item: _center
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
        anchors.margins: _.edge + _.space
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
                    id: _close
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
                        anchors.centerIn: parent
                        implicitWidth: -_main.x - _.space > _.notificationWidth / 2 ? parent.width: 0
                        implicitHeight: -_main.x - _.space > _.notificationWidth / 2 ? parent.height: 0
                        opacity: 0.1
                        radius: _.radius
                        color: _.textColor
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            _card.modelData.dismiss()
                        }
                    }
                }
                Rectangle {
                    id: _action
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
                        anchors.centerIn: parent
                        implicitWidth: _main.x - _.space > _.notificationWidth / 2 ? parent.width: 0
                        implicitHeight: _main.x - _.space > _.notificationWidth / 2 ? parent.height: 0
                        opacity: 0.1
                        radius: _.radius
                        color: _.textColor
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (_card.haveAction) {
                                _card.modelData.actions[0].invoke()
                            }
                            else {
                                _card.modelData.dismiss()
                            }
                        }
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
                        id: _iamge
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
                        anchors.fill: parent
                        anchors.leftMargin: _iamge.visible ? _iamge.width + _.space * 2: _.space
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
                            maximumLineCount: _card.modelData.urgency === Services.Notifications.NotificationUrgency.Critical ? undefined: 1
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
                            maximumLineCount: _card.modelData.urgency === Services.Notifications.NotificationUrgency.Critical ? undefined: 3
                        }
                    }
                    Behavior on x {
                        NumberAnimation { 
                            duration: 300
                            easing.type: Easing.OutCubic 
                        }
                    }
                    DragHandler {
                        xAxis.enabled: true
                        yAxis.enabled: false
                        cursorShape: Qt.ClosedHandCursor
                        onActiveChanged: {
                            if (parent.x < -_.notificationWidth / 2 - _.space) {
                                _card.modelData.dismiss()
                            } 
                            else if (parent.x < -_.notificationWidth / 4) {
                                parent.x = -_.notificationWidth / 4 - _.space
                            }
                            else if (parent.x > _.notificationWidth / 2 + _.space) {
                                if (_card.haveAction) {
                                    _card.modelData.actions[0].invoke()
                                }
                                else {
                                    _card.modelData.dismiss()
                                }
                            }
                            else if (parent.x > _.notificationWidth / 4) {
                                parent.x = _.notificationWidth / 4 + _.space
                            }
                            else {
                                parent.x = 0
                            }
                        }
                    }
                }
            }
        }
    }
}