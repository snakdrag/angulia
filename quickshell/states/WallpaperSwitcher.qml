pragma Singleton
import Qt.labs.folderlistmodel
import QtQuick
import Quickshell

Singleton {
    id: _
    readonly property string wallpaperFile: ("~/Pictures/Wallpapers")
    property list<var> wallpapers: []
    property FolderListModel folderModel: FolderListModel {
        folder: Qt.resolvedUrl(_.wallpaperFile.replace("~", Quickshell.env("HOME")))
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp", ]
        showDirs: false
        sortField: FolderListModel.Name
        onStatusChanged: {
            if (FolderListModel.Ready === status)
            {
                _.updateWallpapers()
            }
        }
    }
    function updateWallpapers()
    {
        this.wallpapers = []
        for (let i = 0; i < this.folderModel.count; i++) {
            let filePath = this.folderModel.get(i, "filePath")
            let fileName = this.folderModel.get(i, "fileName")

            this.wallpapers.push(
            {
                name: fileName,
                path: filePath,
                execute: function() {
                Quickshell.execDetached(["sh", "-c", "~/.config/quickshell/angulia/script/wallpaper.sh \"$0\"", filePath])
            }})
        }
    }

    function search(text)
    {
        // if (text === "")
        // {
        //     return []
        // }
        return [...this.wallpapers].filter(entry => {
        let i = 0;
        return [...text.toLowerCase()].every(
            char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
        )})
    }
}