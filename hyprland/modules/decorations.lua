-----------------------
---- LOOK AND FEEL ----
-----------------------

local theme = "angulia"
local settings = require("~/.config/quickshell/" .. theme .. "/settings/settings")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 0,

        border_size      = 2,

        col              = {
            active_border   = settings.colors.primary,
            inactive_border = settings.colors.outline,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,
    },

    decoration = {
        rounding         = 12,
        rounding_power   = 3,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = false,
            range        = 30,
            render_power = 5,
        },

        blur             = {
            enabled  = true,
            size     = 10,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },
})
