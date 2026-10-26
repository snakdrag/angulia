pragma Singleton
import QtQuick
import Quickshell // for Singleton
import Quickshell.Io

Singleton {
    id: _

    property bool open: (false)

    function call(x, y, data)
    {
        Popup.closeAll()
        this.customX = x
        this.customY = y
        this.menu = data
        this.open = true
    }
    function close()
    {
        this.open = false
    }

    property QtObject menu
    readonly property ObjectModel menuData: (_menu.children)
    property real customX: (0)
    property real customY: (0)

    QsMenuOpener {
        id: _menu
        menu: _.menu
    }
}