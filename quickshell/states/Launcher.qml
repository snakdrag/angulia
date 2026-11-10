pragma Singleton
import Quickshell
import Quickshell.Io
import "../services" as Services
import "../../settings"

Singleton {
    id: _

    property bool open: (false)
    readonly property list<var> commands: (Settings.commands)
    readonly property IpcHandler ipc: (_ipc)
    readonly property ObjectModel applications: (Services.DesktopEntries.applications)

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
            if (_.open) close();
            else
            {
                open();
            }
        }
    }

    function search(text)
    {
        if (text === "") return [];
        if (text[0] === ">")
        {
            return [...this.commands].filter(
                entry => {
                let i = 0;
                return [...text.slice(1).toLowerCase()].every(
                    char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
                )}
            )
        }
        return Services.DesktopEntries.search(text);
    }
}