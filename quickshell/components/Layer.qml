import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect

PanelWindow {

    property bool focus: (false)
    property int layer: (this.layers.Bottom)
    required property Item modules
    readonly property var layers: ({ Overlay: 0, Top: 1, Bottom: 2, Background: 3 })

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true

    color: "transparent"

    exclusionMode: ExclusionMode.Ignore
    mask: Region { id: _region }
    WlrLayershell.keyboardFocus: this.focus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
    WlrLayershell.layer: (
        this.layer === this.layers.Overlay ? WlrLayer.Overlay:
        this.layer === this.layers.Top ? WlrLayer.Top:
        this.layer === this.layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )

    Component.onCompleted: setRegions()

    function setRegions()
    {
        _region.regions = [];
        for (let i = 0; i < this.modules.children.length; i++) {
            let module = this.modules.children[i];
            if (module && module.roundcorners) _region.regions.push(module.region);
        }
    }
}