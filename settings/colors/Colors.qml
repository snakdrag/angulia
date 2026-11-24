pragma Singleton
import QtQuick // for color
import Quickshell // for Singleton
import Quickshell.Io // for FileView and JSON.parse
import qs.angulia.quickshell.custom

Singleton {
    readonly property var data: (JSON.parse(_colors.text()))

    FileView {
        id: _colors
        path: Quickshell.env("HOME") + "/.config/angulia/colors.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }

    readonly property var base16: (this.data.base16)
    readonly property var colors: (this.data.colors)
    readonly property var palettes: (this.data.palettes)

    readonly property string image: (this.data.image)
    readonly property string mode: (this.data.mode)
    readonly property bool isDarkMode: (this.data.is_dark_mode)

    property color primary: (this.colors.primary[this.mode].color)
    property color on_primary: (this.colors.on_primary[this.mode].color)
    property color primary_container: (this.colors.primary_container[this.mode].color)
    property color on_primary_container: (this.colors.on_primary_container[this.mode].color)

    property color secondary: (this.colors.secondary[this.mode].color)
    property color on_secondary: (this.colors.on_secondary[this.mode].color)
    property color secondary_container: (this.colors.secondary_container[this.mode].color)
    property color on_secondary_container: (this.colors.on_secondary_container[this.mode].color)

    property color tertiary: (this.colors.tertiary[this.mode].color)
    property color on_tertiary: (this.colors.on_tertiary[this.mode].color)
    property color tertiary_container: (this.colors.tertiary_container[this.mode].color)
    property color on_tertiary_container: (this.colors.on_tertiary_container[this.mode].color)

    property color error: (this.colors.error[this.mode].color)
    property color on_error: (this.colors.on_error[this.mode].color)
    property color error_container: (this.colors.error_container[this.mode].color)
    property color on_error_container: (this.colors.on_error_container[this.mode].color)

    property color background: (this.colors.background[this.mode].color)
    property color on_background: (this.colors.on_background[this.mode].color)

    property color surface: (this.colors.surface[this.mode].color)
    property color surface_bright: (this.colors.surface_bright[this.mode].color)

    property color surface_container_lowest: (this.colors.surface_container_lowest[this.mode].color)
    property color surface_container_low: (this.colors.surface_container_low[this.mode].color)
    property color surface_container: (this.colors.surface_container[this.mode].color)
    property color surface_container_high: (this.colors.surface_container_high[this.mode].color)
    property color surface_container_highest: (this.colors.surface_container_highest[this.mode].color)

    property color surface_dim: (this.colors.surface_dim[this.mode].color)
    property color surface_tint: (this.colors.surface_tint[this.mode].color)

    property color on_surface: (this.colors.on_surface[this.mode].color)

    property color inverse_surface: (this.colors.inverse_surface[this.mode].color)
    property color inverse_on_surface: (this.colors.inverse_on_surface[this.mode].color)

    property color surface_variant: (this.colors.surface_variant[this.mode].color)
    property color on_surface_variant: (this.colors.on_surface_variant[this.mode].color)

    property color outline: (this.colors.outline[this.mode].color)
    property color outline_variant: (this.colors.outline_variant[this.mode].color)


    Behavior on primary { CustomColorAnimation {} }
    Behavior on on_primary { CustomColorAnimation {} }
    Behavior on primary_container { CustomColorAnimation {} }
    Behavior on on_primary_container { CustomColorAnimation {} }

    Behavior on secondary { CustomColorAnimation {} }
    Behavior on on_secondary { CustomColorAnimation {} }
    Behavior on secondary_container { CustomColorAnimation {} }
    Behavior on on_secondary_container { CustomColorAnimation {} }

    Behavior on tertiary { CustomColorAnimation {} }
    Behavior on on_tertiary { CustomColorAnimation {} }
    Behavior on tertiary_container { CustomColorAnimation {} }
    Behavior on on_tertiary_container { CustomColorAnimation {} }

    Behavior on error { CustomColorAnimation {} }
    Behavior on on_error { CustomColorAnimation {} }
    Behavior on error_container { CustomColorAnimation {} }
    Behavior on on_error_container { CustomColorAnimation {} }

    Behavior on background { CustomColorAnimation {} }
    Behavior on on_background { CustomColorAnimation {} }

    Behavior on surface { CustomColorAnimation {} }
    Behavior on surface_bright { CustomColorAnimation {} }

    Behavior on surface_container_lowest { CustomColorAnimation {} }
    Behavior on surface_container_low { CustomColorAnimation {} }
    Behavior on surface_container { CustomColorAnimation {} }
    Behavior on surface_container_high { CustomColorAnimation {} }
    Behavior on surface_container_highest { CustomColorAnimation {} }

    Behavior on surface_dim { CustomColorAnimation {} }
    Behavior on surface_tint { CustomColorAnimation {} }

    Behavior on on_surface { CustomColorAnimation {} }

    Behavior on inverse_surface { CustomColorAnimation {} }
    Behavior on inverse_on_surface { CustomColorAnimation {} }

    Behavior on surface_variant { CustomColorAnimation {} }
    Behavior on on_surface_variant { CustomColorAnimation {} }

    Behavior on outline { CustomColorAnimation {} }
    Behavior on outline_variant { CustomColorAnimation {} }
}
