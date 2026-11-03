import QtQuick

ListView {

    property bool myMode: (false)
    anchors.fill: parent
    orientation: this.myMode ? ListView.Horizontal: ListView.Vertical
    displaced: Transition { NumberAnimation { properties:"x, y" ;duration: 300; easing.type: Easing.OutCubic } }
    highlightMoveDuration: 300
}