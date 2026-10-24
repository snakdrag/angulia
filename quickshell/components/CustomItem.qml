import QtQuick

Item {
    property real customX: (0)
    property real customY: (0)

    x: Math.max(this.anchors.leftMargin, Math.min(parent.width - this.anchors.rightMargin - this.width, this.customX - this.width / 2))
    y: Math.max(this.anchors.topMargin, Math.min(parent.height - this.anchors.bottomMargin - this.height, this.customY - this.height / 2))
}