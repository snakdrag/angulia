import QtQuick

ListView {
    id: _

    anchors.fill: parent

    property bool isVertical: (false)
    orientation: isVertical?ListView.Vertical: ListView.Horizontal
    reuseItems: true

    displaced: Transition { NumberAnimation { properties:"x, y" ;duration: 300; easing.type: Easing.OutCubic } }
}