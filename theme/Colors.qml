pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    FileView {
        id: colorsFile
        path: Qt.resolvedUrl("./colors.json")
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()
    }

    readonly property var data: (JSON.parse(colorsFile.text()))
    readonly property var base16: (data.base16)
    readonly property var colors: (data.colors)
    readonly property var palettes: (data.palettes)
    readonly property string image: (data.image)
    readonly property bool isDarkMode: (data.is_dark_mode)
    readonly property string mode: (data.mode)

    readonly property color primary: (colors.primary[mode].color)
    readonly property color on_primary: (colors.on_primary[mode].color)
    readonly property color primary_container: (colors.primary_container[mode].color)
    readonly property color on_primary_container: (colors.on_primary_container[mode].color)

    readonly property color secondary: (colors.secondary[mode].color)
    readonly property color on_secondary: (colors.on_secondary[mode].color)
    readonly property color secondary_container: (colors.secondary_container[mode].color)
    readonly property color on_secondary_container: (colors.on_secondary_container[mode].color)

    readonly property color tertiary: (colors.tertiary[mode].color)
    readonly property color on_tertiary: (colors.on_tertiary[mode].color)
    readonly property color tertiary_container: (colors.tertiary_container[mode].color)
    readonly property color on_tertiary_container: (colors.on_tertiary_container[mode].color)

    readonly property color error: (colors.error[mode].color)
    readonly property color on_error: (colors.on_error[mode].color)
    readonly property color error_container: (colors.error_container[mode].color)
    readonly property color on_error_container: (colors.on_error_container[mode].color)

    readonly property color background: (colors.background[mode].color)
    readonly property color on_background: (colors.on_background[mode].color)

    readonly property color surface: (colors.surface[mode].color)
    readonly property color surface_bright: (colors.surface_bright[mode].color)

    readonly property color surface_container_lowest: (colors.surface_container_lowest[mode].color)
    readonly property color surface_container_low: (colors.surface_container_low[mode].color)
    readonly property color surface_container: (colors.surface_container[mode].color)
    readonly property color surface_container_high: (colors.surface_container_high[mode].color)
    readonly property color surface_container_highest: (colors.surface_container_highest[mode].color)

    readonly property color surface_dim: (colors.surface_dim[mode].color)
    readonly property color surface_tint: (colors.surface_tint[mode].color)

    readonly property color on_surface: (colors.on_surface[mode].color)
    
    readonly property color inverse_surface: (colors.inverse_surface[mode].color)
    readonly property color inverse_on_surface: (colors.inverse_on_surface[mode].color)

    readonly property color surface_variant: (colors.surface_variant[mode].color)
    readonly property color on_surface_variant: (colors.on_surface_variant[mode].color)

    readonly property color outline: (colors.outline[mode].color)
    readonly property color outline_variant: (colors.outline_variant[mode].color)
}
