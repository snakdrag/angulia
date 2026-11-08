pragma Singleton
import QtQuick
import Quickshell // for Singleton

Singleton {
    id: _

    property bool open: (false)
    property QtObject menu
    property real customX: (0)
    property real customY: (0)
    readonly property ObjectModel menuData: (_menu.children)

    QsMenuOpener { id: _menu; menu: _.menu }

    function call(x, y, data)
    {
        this.customX = x
        this.customY = y
        this.menu = data
        this.open = true
    }
    function close()
    {
        this.open = false
    }
}