import QtQuick

ListView {
    id: _

    anchors.fill: parent

    property bool isVertical: (false)
    orientation: isVertical?ListView.Vertical: ListView.Horizontal
}