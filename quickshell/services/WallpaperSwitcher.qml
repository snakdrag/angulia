pragma Singleton
import QtQuick
import Quickshell
import Qt.labs.folderlistmodel

Singleton {
    readonly property string wallpaperFile: ("~/Pictures/Wallpapers")
    property list<var> wallpapers: []
    property FolderListModel folderModel: FolderListModel {
        folder: Qt.resolvedUrl(wallpaperFile.replace("~", Quickshell.env("HOME")))
        nameFilters: ["*.png", "*.jpg", "*.jpeg", "*.webp", ]
        showDirs: false
        sortField: FolderListModel.Name
        onStatusChanged: {
            if (FolderListModel.Ready === status)
            {
                updateWallpapers()
            }
        }
    }
    function updateWallpapers()
    {
        wallpapers = []
        for (let i = 0; i < folderModel.count; i++) {
            let filePath = folderModel.get(i, "filePath")
            let fileName = folderModel.get(i, "fileName")

            wallpapers.push(
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
        return [...wallpapers].filter(entry => {
        let i = 0;
        return [...text.toLowerCase()].every(
            char => (i = entry.name.toLowerCase().indexOf(char, i)) !== -1 && i++ >= 0
        )})
    }
}