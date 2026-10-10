import QtQuick

DragHandler {
    required property Item item
    onTranslationChanged: {
        let parentWidth = item.parent.width
        let parentHeight = item.parent.height

        let centerX = item.x + item.width / 2
        let centerY = item.y + item.height / 2

        let isXCenter = parentWidth / 3 < centerX && centerX < parentWidth / 3 * 2
        let isYCenter = parentHeight / 3 < centerY && centerY < parentHeight / 3 * 2

        if (isXCenter && !isYCenter) item.isVertical = false
        if (isYCenter && !isXCenter) item.isVertical = true
    }
    onActiveChanged: {
        let parentWidth = item.parent.width
        let parentHeight = item.parent.height

        let centerX = item.x + item.width / 2
        let centerY = item.y + item.height / 2

        let edgeX = Math.min(centerX, parentWidth - centerX)
        let edgeY = Math.min(centerY, parentHeight - centerY)
        if (item.x < item.edge) item.x = item.edge
        if (item.x + item.width > parentWidth - item.edge) item.x = parentWidth - item.width - item.edge
        if (item.y < item.edge) item.y = item.edge
        if (item.y + item.height > parentHeight - item.edge) item.y = parentHeight - item.height - item.edge

        let temp = edgeX / parentWidth > edgeY / parentHeight
        if (!temp && centerX < parentWidth / 2) item.x = item.edge
        if (!temp && centerX > parentWidth / 2) item.x = parentWidth - item.width - item.edge
        if (temp && centerY < parentHeight / 2) item.y = item.edge
        if (temp && centerY > parentHeight / 2) item.y = parentHeight - item.height - item.edge
        set()
    }
}