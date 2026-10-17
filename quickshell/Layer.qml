import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect

PanelWindow {
    Component.onCompleted: setRegions()

    readonly property var layers: ({ Overlay: 0, Top: 1, Bottom: 2, Background: 3 })
    property int layer: (this.layers.Top)

    property Item modules: (_item)
    property bool keyboardFocus: (false)

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore
    mask: Region { id: _region }
    Item {
        id: _item
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
            onClicked: {
                root.ipcCloseAll()
                _popup.close()
            }
        }
    }

    WlrLayershell.keyboardFocus: this.keyboardFocus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
    WlrLayershell.layer: (
        layer === this.layers.Overlay ? WlrLayer.Overlay:
        layer === this.layers.Top ? WlrLayer.Top:
        layer === this.layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )
    BackgroundEffect.blurRegion: Region { item: _item }

    function setRegions()
    {
        _region.regions = [];
        for (let i = 0; i < this.modules.children.length; i++) {
            let module = this.modules.children[i];
            if (module && module.roundcorners !== undefined) _region.regions.push(module.region);
        }
    }
}