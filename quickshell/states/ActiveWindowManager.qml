pragma Singleton
import Quickshell // for Singleton

Singleton {

    property bool open: (false)

    function call(x, y, width, height)
    {
        this.customX = x
        this.customY = y
        this.width = width
        this.height = height
        this.open = true
    }
    function close()
    {
        this.open = false
    }

    property real customX: (0)
    property real customY: (0)

    property int width: (0)
    property int height: (0)
}