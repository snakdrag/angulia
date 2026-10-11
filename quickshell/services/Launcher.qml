pragma Singleton
import QtQuick
import Quickshell

Singleton {
    function search(text)
    {
        if (text === "")
        {
            return []
        }
        else
        {
            return DesktopEntries.applications.values.filter(
                entry => {
                let i = 0;
                return [...text.toLowerCase()].every(
                    char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
                )}
            )
        }
    }
}