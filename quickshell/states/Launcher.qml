pragma Singleton
import Quickshell
import "../services" as Services
import "../../settings"

Singleton {
    id: _

    property bool open: (false)
    readonly property list<var> commands: (Settings.commands)
    readonly property ObjectModel applications: (Services.DesktopEntries.applications)

    GlobalShortcut {
        name: "launcher"
        onCalled: _.toggle()
    }

    function toggle()
    {
        if (this.open) this.open = false;
        else
        {
            Ipc.closeAll()
            this.open = true
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