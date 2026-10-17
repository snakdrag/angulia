import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import "../states"
import "../angulia"
import "../../settings"

Angulia {
    id: _

    _data: Settings.wallpaperswitcher

    implicitWidth: Math.max(_list.contentWidth, this.cardWidth) + this.space * 2
    implicitHeight: (
        _list.contentWidth === 0 || _list.contentHeight === 0 ? 0: Math.max(
            _list.contentHeight,
            (this.isVertical ? 0: this.cardHeight)
        ) + this.space
    ) + _field.height + this.space * 2

    property int selectedIndex: (0)
    function getWallpaper()
    {
        let values = _list.model.values
        if (!values) return;
        for (let i = 0; i < values.length; i++)
        {
            if (values[i].path === Settings.colors.image)
            {
                this.selectedIndex = i;
                return;
            }
        }
        this.selectedIndex = 0;
    }

    show: false
    readonly property IpcHandler ipc: (_ipc)

    IpcHandler {
        id: _ipc
        target: "wallpaperswitcher"
        function open()
        {
            root.ipcCloseAll()
            _.show = true
            _.getWallpaper()
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
        y: _._data.inputAtTop ? this.anchors.topMargin: Math.max(
            parent.height - this.height - this.anchors.bottomMargin,
            this.anchors.topMargin
        )
        anchors.left: parent.left
        anchors.right: parent.right
        height: _.bar.height - this.space * 2
        space: _.space
        radius: _.radius
        color: _.textColor
        backgroundColor: _.cardColor
        placeholderText: "Search..."
        verticalAlignment: TextInput.AlignVCenter
        visible: _.show
        font: _._data.font
        onTextChanged: _.selectedIndex = 0
        Keys.onUpPressed: if (_list.count > 0) _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
        Keys.onDownPressed: if (_list.count > 0) _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
        Keys.onLeftPressed: if (_list.count > 0) _.selectedIndex = Math.max(_.selectedIndex - 1, 0)
        Keys.onRightPressed: if (_list.count > 0) _.selectedIndex = Math.min(_.selectedIndex + 1, _list.count - 1)
        Keys.onReturnPressed: {
            if (_list.count > 0)
            {
                _list.currentItem.modelData.execute()
                _ipc.close()
            }
            else
            {
                _ipc.close()
            }
        }
        Keys.onEscapePressed: _ipc.close()
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
            model: ScriptModel { values: WallpaperSwitcher.search(_field.text).sort((a, b) => a.name.localeCompare(b.name)) }
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: this.isVertical ? this.height / 2 - _.cardHeight / 2: this.width / 2 - _.cardWidth / 2
            preferredHighlightEnd: this.isVertical ? this.height / 2 + _.cardHeight / 2: this.width / 2 + _.cardWidth / 2
            delegate: Card {
                required property var modelData
                required property int index

                active: this.index === _.selectedIndex
                activeColor: _.textColor
                color: _.cardColor

                implicitWidth: _.cardWidth
                implicitHeight: _.cardHeight

                space: _.space
                radius: _.radius
                isVertical: _.isVertical
                centerIn: true

                imageWidth: this.width
                imageHeight: this.height
                imageSource: this.modelData.path
                imageFillMode: Image.PreserveAspectCrop

                mouseArea.onClicked: {
                    this.modelData.execute()
                    _ipc.close()
                }
            }
        }
    }
}
