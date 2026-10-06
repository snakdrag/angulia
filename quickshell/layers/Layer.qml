import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect

PanelWindow {
    readonly property var layers: ({ Overlay: 0, Top: 1, Bottom: 2, Background: 3 })
    property int layer: (layers.Top)
    WlrLayershell.layer: (
        layer === layers.Overlay ? WlrLayer.Overlay:
        layer === layers.Top ? WlrLayer.Top:
        layer === layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )

    property bool keyboardFocus: (false)
    WlrLayershell.keyboardFocus: keyboardFocus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None

    property bool enableBlur: (true)
    Item { id: _item; anchors.fill: parent }
    BackgroundEffect.blurRegion: Region { item: enableBlur ? _item: null }

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    mask: Region {}
}