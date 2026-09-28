import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../custom" as Custom
import qs.angulia.theme

Custom.Item {
    id: _
    anchors.fill: parent
    direction: Settings.launcherDirection

    property real radius: (Settings.radius)
    property color color: (Colors.surface)
    property color cardColor: (Colors.surface_container)
    property color textColor: (Colors.on_surface)
    property int edge: (Settings.edge)
    property int float: (Settings.float)
    property int space: (Settings.space)

    property int launcherWidth: (Settings.launcherWidth)
    property int launcherHeight: (Settings.launcherHeight)
    property int cardHeight: (Settings.launcherCardHeight)

    property font nameFont: (Settings.launcherNameFont)
    property font commentFont: (Settings.launcherCommentFont)

    property int selectedIndex: (0)

    anchors.margins: edge + float

    property bool opened: (false)
    property bool inputAtTop: (Settings.launcherInputAtTop)

    readonly property int contentHeight: (Math.min(
        _list.contentHeight,
        (
            isLeftRight ?
            parent.height / 2 - edge - space - launcherHeight:
            parent.height / 2 - edge - space - float - launcherHeight
        )
    ))

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open() {
            _.opened = true
            _search.text = ""
            _search.forceActiveFocus()
        }
        function close() {
            _.opened = false
        }
        function toggle() {
            if(!_.opened){ open() }
            else { close() }
        }
    }
    Custom.Rectangle {
        anchors.top: _.isTop ? parent.top: undefined
        anchors.left: _.isLeft ? parent.left: undefined
        anchors.right: _.isRight ? parent.right: undefined
        anchors.bottom: _.isBottom ? parent.bottom: undefined
        anchors.horizontalCenter: _.isTopBottom ? parent.horizontalCenter: undefined
        anchors.verticalCenter: _.isLeftRight ? parent.verticalCenter: undefined

        implicitWidth: _.opened ? _.launcherWidth: 0
        implicitHeight: _.opened ? (_.contentHeight === 0 ? _.launcherHeight: _.contentHeight + _.space + _.launcherHeight): 0

        float: _.float
        radius: _.radius
        color: _.color
        Custom.Rectangle {
            anchors.top: _.inputAtTop ? parent.top: undefined
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: !_.inputAtTop ? parent.bottom: undefined
            anchors.margins: _.space
            implicitHeight: _.opened ? _.launcherHeight - _.space * 2: 0
            radius: _.radius
            color: _.cardColor
            show: _.opened
            float: true
            TextInput {
                id: _search
                anchors.fill: parent
                anchors.leftMargin: _.space
                anchors.rightMargin: _.space
                verticalAlignment: TextInput.AlignVCenter
                font: _.nameFont
                color: _.textColor
                cursorVisible: activeFocus
                clip: true
                onTextChanged: {_.selectedIndex = 0}
                Keys.onEscapePressed: {_ipc.close()}
                Keys.onDownPressed: {if (_list.count > 0) {
                    _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }}
                Keys.onUpPressed: {if (_list.count > 0) {
                    _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }}
                Keys.onReturnPressed: {
                    if (_list.count > 0) {
                        _list.currentItem.modelData.execute()
                        _ipc.close()
                    }
                    else {_ipc.close()}
                }
                Text {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    text: "Search..."
                    font: _search.font
                    color: _.textColor
                    opacity: 0.5
                    visible: _search.text === ""
                }
            } 
        }
        Custom.ClippingRectangle {
            anchors.fill: parent
            anchors.margins: _.space
            anchors.topMargin: _.inputAtTop ? _.launcherHeight: _.space
            anchors.bottomMargin: !_.inputAtTop ? _.launcherHeight: _.space
            radius: _.radius
            color: "transparent"
            show: _.opened
            ListView {
                id: _list
                anchors.fill: parent
                spacing: _.space
                currentIndex: _.selectedIndex
                model: ScriptModel {
                    values: _search.text === "" ? []: DesktopEntries.applications.values.filter(
                        entry => {
                            let i = 0;
                            return [..._search.text.toLowerCase()].every(
                                char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
                            );
                        }
                    ).sort((a, b) => a.name.localeCompare(b.name))
                }
                delegate: Rectangle {
                    id: _card
                    required property var modelData
                    required property int index
                    implicitWidth: _.launcherWidth - _.space * 2
                    implicitHeight: _.cardHeight
                    color: _.cardColor
                    radius: _.radius
                    Image {
                        id: _image
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: _.space
                        width: _card.implicitHeight - _.space * 2
                        height: _card.implicitHeight - _.space * 2
                        source: Quickshell.iconPath(_card.modelData.icon, true) || ""
                        fillMode: Image.PreserveAspectFit
                        visible: status === Image.Ready && source != ""
                    }
                    Item {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        implicitHeight: _comment.text !== "" ? _name.height + _comment.height: _name.height
                        anchors.leftMargin: _image.visible ? _image.width + _.space * 2: _.space
                        anchors.margins: _.space
                        Text {
                            id: _name
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            text: _card.modelData.name
                            font: _.nameFont
                            color: _.textColor
                            elide: Text.ElideRight
                            wrapMode: Text.WrapAnywhere
                            maximumLineCount: 1
                        }
                        Text {
                            id: _comment
                            anchors.top: _name.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            text: _card.modelData.comment
                            font: _.commentFont
                            color: _.textColor
                            elide: Text.ElideRight
                            wrapMode: Text.WrapAnywhere
                            maximumLineCount: 1
                        }
                    }
                    Custom.Cover {
                        show: _card.index === _.selectedIndex
                        color: _.textColor
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            _card.modelData.execute()
                            _ipc.close()
                        }
                        onEntered: _.selectedIndex = _card.index
                    }
                }
            }
        }
    }
}