import QtQuick

ListView {
    anchors.fill: parent

    property bool isVertical: (false)
    orientation: this.isVertical ? ListView.Vertical: ListView.Horizontal
    reuseItems: true

    displaced: Transition { NumberAnimation { properties:"x, y" ;duration: 300; easing.type: Easing.OutCubic } }
    highlightMoveDuration: 300
}