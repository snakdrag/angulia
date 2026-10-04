import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"
    focusable: true
    mask: Region {}
    exclusionMode: ExclusionMode.Ignore
    Item { id: _item; anchors.fill: parent}
    BackgroundEffect.blurRegion: Region { item: _item }
}