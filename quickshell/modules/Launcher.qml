import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../custom" as Custom

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
            parent.height / 2 - edge - space - _input.height - space * 2:
            parent.height / 2 - edge - space - float - _input.height - space * 2
        )
    ))
    property int selectedIndex: (0)

    implicitWidth: show ? Math.max(contentWidth, launcherCardWidth) + space * 2: 0
    implicitHeight: (
        show ? 
        (
            contentHeight !== 0 && contentWidth !== 0 ?
            Math.max(contentHeight, launcherCardHeight) + space + _input.height:
            _input.height
        ) + space * 2:
        0
    )

    show: false

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open() {
            _.show = true
            _search.text = ""
            _search.forceActiveFocus()
        }
        function close() { _.show = false }
        function toggle() {
            if(!_.show){ open() }
            else { close() }
        }
    }
    Rectangle {
        id: _input
        anchors.top: _.launcherInputAtTop ? parent.top: undefined
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: !_.launcherInputAtTop ? parent.bottom: undefined
        anchors.margins: _.space
        implicitHeight: _.launcherInputHeight
        radius: _.radius
        color: _.cardColor
        visible: _.show
        TextInput {
            id: _search
            anchors.fill: parent
            anchors.leftMargin: _.space
            anchors.rightMargin: _.space
            verticalAlignment: TextInput.AlignVCenter
            font: _.launcherNameFont
            color: _.textColor
            cursorVisible: activeFocus
            clip: true
            onTextChanged: {_.selectedIndex = 0}
            Keys.onEscapePressed: {_ipc.close()}
            Keys.onUpPressed: {if (_list.count > 0) {
                _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }}
            Keys.onDownPressed: {if (_list.count > 0) {
                _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }}
            Keys.onLeftPressed: {if (_list.count > 0) {
                _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
            }}
            Keys.onRightPressed: {if (_list.count > 0) {
                _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
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
    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        anchors.topMargin: _.launcherInputAtTop ? _input.height + _.space * 2: _.space
        anchors.bottomMargin: !_.launcherInputAtTop ? _input.height + _.space * 2: _.space
        radius: _.radius
        color: "transparent"
        visible: _.show
        ListView {
            id: _list
            anchors.fill: parent
            spacing: _.space
            orientation: _.launcherInputIsVertical ? ListView.Vertical: ListView.Horizontal
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
                implicitWidth: _.launcherCardWidth
                implicitHeight: _.launcherCardHeight
                color: _.cardColor
                radius: _.radius
                Image {
                    id: _image
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: _.space
                    width: _card.height - _.space * 2
                    height: _card.height - _.space * 2
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
                        font: _.launcherNameFont
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
                        font: _.launcherCommentFont
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
                }
            }
        }
    }
}