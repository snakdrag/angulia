import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../states"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.launcher

    implicitWidth: Math.max(_list.contentWidth, cardWidth) + space * 2
    implicitHeight: (noContent ? 0: Math.max(_list.contentHeight, (isVertical ? 0: cardHeight)) + space) + _field.height + _.space * 2

    property bool noContent: (_list.contentWidth === 0 || _list.contentHeight === 0)

    property int selectedIndex: (0)

    show: false
    readonly property IpcHandler ipc: (_ipc)

    IpcHandler {
        id: _ipc
        target: "launcher"
        function open()
        {
            ipcCloseAll()
            _.show = true
            _.selectedIndex = 0
            _field.text = ""
            _field.forceActiveFocus()
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
    TextField {
        id: _field
        y: _._data.inputAtTop ? anchors.topMargin: Math.max(parent.height - height - anchors.bottomMargin, anchors.topMargin)
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: _.bar.height - space * 2
        space: _.space
        radius: _.radius
        color: _.textColor
        backgroundColor: _.cardColor
        placeholderText: "Search..."
        verticalAlignment: TextInput.AlignVCenter
        visible: _.show
        font: _._data.nameFont
        onTextChanged: _.selectedIndex = 0
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
            else {
                _ipc.close()
            }
        }
        Keys.onEscapePressed: {_ipc.close()}
    }
    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: _.space
        anchors.topMargin: _._data.inputAtTop ? _field.height + _.space * 2: _.space
        anchors.bottomMargin: _._data.inputAtTop ? _.space: _field.height + _.space * 2
        radius: _.radius
        color: _.backgroundColor
        visible: _.show
        List {
            id: _list
            spacing: _.space
            isVertical: _.isVertical
            currentIndex: _.selectedIndex
            displaced: null
            model: ScriptModel { values: Launcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name)) }
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

                imageWidth: _.imageWidth
                imageHeight: _.imageHeight
                imageSource: Quickshell.iconPath(modelData.icon, true)

                topText: modelData.name
                topFont: _._data.nameFont
                topMaximumLineCount: 1

                bottomText: modelData.comment
                bottomFont: _._data.commentFont
                bottomMaximumLineCount: 1

                Mouse {
                    onClicked: {
                        _card.modelData.execute()
                        _ipc.close()
                    }
                }
            }
        }
    }
}