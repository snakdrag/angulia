import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../custom" as Custom
import qs.angulia.theme
import qs.angulia.quickshell.settings

Custom.Angulia {
    id: _
    direction: (1)

    property int launcherWidth: (400)
    property int launcherHeight: (60)
    property font appFont: ({
        family: "Inter",
        bold: true,
    })
    property font describeFont: ({
        family: "Inter",
    })
    property int space: (10)
    property color cardColor: (Colors.surface_container)
    property bool launcherOpened: (false)

    property string query: ("")
    property int selectedIndex: (0)

    readonly property int contentHeight: (Math.min(_list.contentHeight, Screen.height / 2))

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open() { _.launcherOpened = true }
        function close() { _.launcherOpened = false }
        function toggle() { 
            if(!_.launcherOpened){ open() }
            else { close() }
        }
    }
    readonly property Region region: (_region)
    Region {
        id: _region
        regions: [__.region, ]
    }
    Custom.RoundRectangle {
        id: __
        rectangleWidth: _.launcherOpened ? _.launcherWidth: 0
        rectangleHeight: _.launcherOpened ? _.contentHeight: 0
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined
        anchors.margins: _.edge
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
        ClippingRectangle {
            anchors.centerIn: parent.rectangle
            implicitWidth: _.launcherOpened ? _.launcherWidth - _.space * 2: 0
            implicitHeight: _.launcherOpened ? _.contentHeight - _.space * 2: 0
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
                model: DesktopEntries.applications
                delegate: Item {
                    id: _card
                    required property var modelData
                    implicitWidth: _.launcherWidth - _.space * 2
                    implicitHeight: _.launcherHeight
                    Rectangle {
                        anchors.fill: parent
                        radius: _.radius
                        color: _.cardColor
                        Image {
                            id: _image
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: _.space
                            width: _.launcherHeight - _.space * 2
                            height: _.launcherHeight - _.space * 2
                            source: Quickshell.iconPath(_card.modelData.icon, true) || ""
                            fillMode: Image.PreserveAspectFit
                            visible: status === Image.Ready && source != ""
                        }
                        Item {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            implicitHeight: _genericName.text !== "" ? _name.height + _genericName.height: _name.height
                            anchors.leftMargin: _image.visible ? _image.width + _.space * 2: _.space
                            anchors.margins: _.space
                            Text {
                                id: _name
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right
                                text: _card.modelData.name
                                color: _.textColor
                                font: _.appFont
                                elide: Text.ElideRight
                                wrapMode: Text.WrapAnywhere
                            }
                            Text {
                                id: _genericName
                                anchors.top: _name.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                text: _card.modelData.genericName
                                color: _.textColor
                                font: _.describeFont
                                elide: Text.ElideRight
                                wrapMode: Text.WrapAnywhere
                            }
                        }
                        Rectangle {
                            id: _active
                            anchors.fill: parent
                            radius: _.radius
                            opacity: 0.1
                            color: _.textColor
                            visible: false
                        }
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: _card.modelData.execute()
                            onEntered: _active.visible = true
                            onExited: _active.visible = false
                        }
                    }
                }
            }
        }
    }
}