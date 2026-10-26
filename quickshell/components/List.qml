import QtQuick

ListView {

    property bool myMode: (false)
    anchors.centerIn: parent
    implicitWidth: this.myMode ? Math.min(this.contentWidth, parent.width): parent.width
    implicitHeight: this.myMode ? parent.height: Math.min(this.contentHeight, parent.height)
    orientation: this.myMode ? ListView.Horizontal: ListView.Vertical
    displaced: Transition { NumberAnimation { properties:"x, y" ;duration: 300; easing.type: Easing.OutCubic } }
    highlightMoveDuration: 300
}