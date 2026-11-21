import QtQuick
import "../custom"

ListView {

    property bool myMode: (false)

    anchors.fill: parent

    highlightMoveDuration: 300
    orientation: this.myMode ? ListView.Horizontal: ListView.Vertical

    displaced: Transition { CustomNumberAnimation { properties:"x, y" } }
}