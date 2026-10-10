import QtQuick // for Item
import Quickshell // for PanelWindow
import Quickshell.Wayland // for WlrLayershell and BackgroundEffect

PanelWindow {
    id: _

    Component.onCompleted: setRegions()

    readonly property var layers: ({ Overlay: 0, Top: 1, Bottom: 2, Background: 3 })
    property int layer: (layers.Top)

    property list<Item> modules: ([])
    property bool keyboardFocus: (false)
    property bool enableBlur: (true)

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore
    mask: Region { id: _region }
    Item { id: _item; anchors.fill: parent }

    WlrLayershell.keyboardFocus: keyboardFocus ? WlrKeyboardFocus.Exclusive: WlrKeyboardFocus.None
    WlrLayershell.layer: (
        layer === layers.Overlay ? WlrLayer.Overlay:
        layer === layers.Top ? WlrLayer.Top:
        layer === layers.Bottom ? WlrLayer.Bottom:
        WlrLayer.Background
    )
    BackgroundEffect.blurRegion: Region { item: enableBlur ? _item: null }

    function setRegions()
    {
        _region.regions = [];
        for (let i = 0; i < modules.length; i++) {
            let module = modules[i];
            if (module && module._itemName === "Angulia")
            {
                _region.regions.push(module.region);
            }
        }
    }
}