pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "../services" as Services

Singleton {
    id: _

    property bool open: (false)
    property list<Command> commands: [
    Command {
        icon: "system-reboot"
        name: "Reboot"
        command: ["systemctl", "reboot"]
    },
    Command {
        icon: "system-shutdown"
        name: "Poweroff"
        command: ["systemctl", "poweroff"]
    },
    Command {
        icon: "system-log-out"
        name: "Logout"
        command: ["sh", "-c", "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"]
    },
    Command {
        icon: "preferences-desktop-wallpaper"
        name: "Wallpaper switcher"
        command: ["sh", "-c", "qs ipc call wallpaperswitcher open"]
    }]
    readonly property IpcHandler ipc: (_ipc)
    readonly property ObjectModel applications: (Services.DesktopEntries.applications)

    component Command: QtObject {
    property string icon: ("")
    property string name: ("")
    property string comment: ("")
    property list<string> command: []
    function execute()
    {
        Quickshell.execDetached(command)
    }}

    IpcHandler {
        id: _ipc

        target: "launcher"

        function open()
        {
            Ipc.closeAll()
            _.open = true
        }
        function close()
        {
            _.open = false
        }
        function toggle()
        {
            if (_.open)
            {
                close()
            }
            else {
                open()
            }
        }
    }

    function search(text)
    {
        if (text === "") return [];
        if (text[0] === ">")
        {
            return [...this.commands].filter(entry => {
            let i = 0;
            return [...text.slice(1).toLowerCase()].every(
                char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
            )})
        }
        else
        {
            return Services.DesktopEntries.search(text)
        }
    }
}