import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: _
    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"
    focusable: true
    mask: Region {}
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    Item { id: _item; anchors.fill: parent}
    BackgroundEffect.blurRegion: Region { item: _item }
}