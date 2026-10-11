import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../services"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.launcher

    implicitWidth: Math.max(contentWidth, cardWidth) + space * 2
    implicitHeight: Math.min(tempHeight, parent.height / 2 - edge - (isLeft || isRight ? 0: float))

    _contentWidth: _list.contentWidth
    _contentHeight: _list.contentHeight

    property int selectedIndex: (0)
    readonly property int tempHeight: _input.height + space * 2 + (noContent ? 0: Math.max(contentHeight, cardHeight) + space)

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
            _._data.inputAtTop ?
            anchors.topMargin:
            Math.max(parent.height - implicitHeight - anchors.bottomMargin, anchors.topMargin)
        )
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: _.space
        implicitHeight: _.show ? _.bar.height - _.space * 2: 0
        radius: _.radius
        color: _.cardColor
        visible: _.show
        TextInput {
            id: _search
            anchors.fill: parent
            anchors.leftMargin: _.space
            anchors.rightMargin: _.space
            verticalAlignment: TextInput.AlignVCenter
            font: _._data.nameFont
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
        anchors.topMargin: _._data.inputAtTop ? _input.height + _.space * 2: _.space
        anchors.bottomMargin: _._data.inputAtTop ? _.space: _input.height + _.space * 2
        radius: _.radius
        color: _.backgroundColor
        visible: _.show
        List {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            currentIndex: _.selectedIndex
            displaced: null
            model: ScriptModel { values: Launcher.search(_search.text).sort((a, b) => a.name.localeCompare(b.name)) }
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
                topFont: _._data.nameFont
                topMaximumLineCount: 1

                bottomText: modelData.comment
                bottomFont: _._data.commentFont
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