import QtQuick
import "../custom"

ListView {

    property bool myMode: (false)

    anchors.fill: parent

    highlightMoveDuration: 300
    orientation: this.myMode ? ListView.Horizontal: ListView.Vertical

    displaced: Transition { CustomNumberAnimation { properties:"x, y" } }
    add: Transition { CustomNumberAnimation { properties:"scale, opacity"; from: 0; to: 1 } }
    remove: Transition { CustomNumberAnimation { properties:"scale, opacity"; from: 1; to: 0 } }
}