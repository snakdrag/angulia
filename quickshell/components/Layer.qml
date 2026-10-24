import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect

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
    property Region region: (_region)

    property bool focus: (false)
    WlrLayershell.keyboardFocus: this.focus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
    WlrLayershell.layer: (
        this.layer === this.layers.Overlay ? WlrLayer.Overlay:
        this.layer === this.layers.Top ? WlrLayer.Top:
        this.layer === this.layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )
}