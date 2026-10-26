import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect
import "../states"

PanelWindow {

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"

    readonly property var layers: ({ Overlay: 0, Top: 1, Bottom: 2, Background: 3 })
    property int layer: (this.layers.Bottom)

    exclusionMode: ExclusionMode.Ignore

    mask: Region { id: _region }
    Item {
        id: _item
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
            onClicked: {
                Ipc.closeAll()
                Popup.closeAll()
            }
        }
    }
    BackgroundEffect.blurRegion: Region { item: _item }

    property bool focus: (false)
    WlrLayershell.keyboardFocus: this.focus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
    WlrLayershell.layer: (
        this.layer === this.layers.Overlay ? WlrLayer.Overlay:
        this.layer === this.layers.Top ? WlrLayer.Top:
        this.layer === this.layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )

    property Item modules: (_item)
    function setRegions()
    {
        _region.regions = [];
        for (let i = 0; i < this.modules.children.length; i++) {
            let module = this.modules.children[i];
            if (module && module.roundcorners !== undefined) _region.regions.push(module.region);
        }
    }
    Component.onCompleted: setRegions()
}