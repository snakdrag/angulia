import QtQuick
import "../custom"

ListView {

    property bool myMode: (false)

    anchors.fill: parent

    orientation: this.myMode ? ListView.Horizontal: ListView.Vertical

    displaced: Transition { CustomNumberAnimation { properties:"x, y" } }
    highlightMoveDuration: 300
}