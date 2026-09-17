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
        implicitWidth: _.notificationWidth
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
            delegate: Rectangle {
                id: _card
                required property var modelData
                implicitWidth: _.notificationWidth
                implicitHeight: Math.max(_.notificationHeight, _summary.height + _body.height + _.space * 2)
                radius: _.radius
                color: _.cardColor
                Image {
                    id: _iamge
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
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
                    }
                }
                DragHandler {
                    xAxis.enabled: true
                    xAxis.minimum: -_.notificationWidth
                    xAxis.maximum: _.notificationWidth
                    yAxis.enabled: false
                    onActiveChanged: {
                        if (_card.x < -_.notificationWidth / 2) {
                            _card.modelData.dismiss()
                        } 
                        else if (_card.x > _.notificationWidth / 2) {
                            if (_card.modelData.actions.length > 0) {
                                _card.modelData.actions[0].invoke()
                            }
                            else {
                                _card.modelData.dismiss()
                            }
                        }
                        else {
                            _card.x = 0
                        }
                    }
                }
            }
        }
    }
}