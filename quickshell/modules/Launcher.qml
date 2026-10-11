import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../custom" as Custom
import "../angulia"
import "../../settings"

Angulia {
    id: _

    customX: parent.width / 2

    property var launcher: (Settings.launcher)
    readonly property var bar: (Settings.bar)
    cardWidth: launcher.card.width
    cardHeight: launcher.card.height
    iconSize: launcher.iconSize
    property int inputHeight: (bar.height - space * 2)
    property bool launcherInputAtTop: (Settings.launcherInputAtTop)
    property font launcherNameFont: (Settings.launcherNameFont)
    property font launcherCommentFont: (Settings.launcherCommentFont)

    isVertical: false
    _contentWidth: _list.contentWidth
    _contentHeight: _list.contentHeight
    property int selectedIndex: (0)

    implicitWidth: show ? Math.max(contentWidth, cardWidth) + space * 2: 0
    implicitHeight: (
        show ?
        (
            noContent ?
            _input.height:
            Math.max(contentHeight - space - _input.height, cardHeight) + space + _input.height
        ) + space * 2:
        0
    )

    show: false

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open()
        {
            _.show = true
            _search.text = ""
            _search.forceActiveFocus()
        }
        function close()
        {
            _.show = false
        }
        function toggle()
        {
            if (_.show)
            {
                close()
            }
            else {
                open()
            }
        }
    }
    Rectangle {
        id: _input
        y: (
            _.launcherInputAtTop ?
            anchors.topMargin:
            Math.max(parent.height - implicitHeight - anchors.bottomMargin, anchors.topMargin)
        )
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: _.space
        implicitHeight: _.show ? _.inputHeight: 0
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
            clip: true
            onTextChanged: {_.selectedIndex = 0}
            Keys.onEscapePressed: {_ipc.close()}
            Keys.onUpPressed: {
                if (_list.count > 0)
                {
                    _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }
            }
            Keys.onDownPressed: {
                if (_list.count > 0)
                {
                    _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }
            }
            Keys.onLeftPressed: {
                if (_list.count > 0)
                {
                    _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }
            }
            Keys.onRightPressed: {
                if (_list.count > 0)
                {
                    _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
                    _list.positionViewAtIndex(_.selectedIndex, ListView.Contain)
                }
            }
            Keys.onReturnPressed: {
                if (_list.count > 0)
                {
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
        anchors.bottomMargin: _.launcherInputAtTop ? _.space: _input.height + _.space * 2
        radius: _.radius
        color: _.backgroundColor
        visible: _.show
        CustomListView {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            currentIndex: _.selectedIndex
            displaced: null
            model: ScriptModel {
                values: _search.text === "" ? []: DesktopEntries.applications.values.filter(
                    entry => {
                    let i = 0;
                    return [..._search.text.toLowerCase()].every(
                        char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
                    );}
                ).sort((a, b) => a.name.localeCompare(b.name))
            }
            delegate: Card {
                id: _card
                required property var modelData
                required property int index

                active: _card.index === _.selectedIndex
                activeColor: _.textColor
                color: _.cardColor

                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight

                space: _.space
                radius: _.radius
                isVertical: _.isVertical

                iconSize: _.iconSize
                iconSource: Quickshell.iconPath(modelData.icon, true)

                topText: modelData.name
                topFont: _.launcherNameFont
                topMaximumLineCount: 1

                bottomText: modelData.comment
                bottomFont: _.launcherCommentFont
                bottomMaximumLineCount: 1

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