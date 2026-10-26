pragma Singleton
import Quickshell // for Singleton and DesktopEntries

Singleton {
    readonly property ObjectModel applications: (DesktopEntries.applications)

    function search(text)
    {
        return this.applications.values.filter(
            entry => {
            let i = 0;
            return [...text.toLowerCase()].every(
                char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
            )}
        )
    }
}