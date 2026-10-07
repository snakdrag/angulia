local f = assert(io.open((debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./") .. "colors.json", "r"))
local data = f:read("*a")
f:close()

local mode = data:match('"mode"%s*:%s*"([^"]+)"')

local function matchJSON(jsonData, keys)
    local matchSTR = ''
    for _, key in ipairs(keys) do
        matchSTR = matchSTR .. '"' .. key .. '"%s*:%s*.-'
    end
    matchSTR = matchSTR .. '"([^"]+)"'
    return jsonData:match(matchSTR)
end

return {
    primary = matchJSON(data, { "colors", "primary", mode, "color" }),
    on_primary = matchJSON(data, { "colors", "on_primary", mode, "color" }),
    primary_container = matchJSON(data, { "colors", "primary_container", mode, "color" }),
    on_primary_container = matchJSON(data, { "colors", "on_primary_container", mode, "color" }),

    secondary = matchJSON(data, { "colors", "secondary", mode, "color" }),
    on_secondary = matchJSON(data, { "colors", "on_secondary", mode, "color" }),
    secondary_container = matchJSON(data, { "colors", "secondary_container", mode, "color" }),
    on_secondary_container = matchJSON(data, { "colors", "on_secondary_container", mode, "color" }),

    tertiary = matchJSON(data, { "colors", "tertiary", mode, "color" }),
    on_tertiary = matchJSON(data, { "colors", "on_tertiary", mode, "color" }),
    tertiary_container = matchJSON(data, { "colors", "tertiary_container", mode, "color" }),
    on_tertiary_container = matchJSON(data, { "colors", "on_tertiary_container", mode, "color" }),

    error = matchJSON(data, { "colors", "error", mode, "color" }),
    on_error = matchJSON(data, { "colors", "on_error", mode, "color" }),
    error_container = matchJSON(data, { "colors", "error_container", mode, "color" }),
    on_error_container = matchJSON(data, { "colors", "on_error_container", mode, "color" }),

    background = matchJSON(data, { "colors", "background", mode, "color" }),
    on_background = matchJSON(data, { "colors", "on_background", mode, "color" }),

    surface = matchJSON(data, { "colors", "surface", mode, "color" }),
    surface_bright = matchJSON(data, { "colors", "surface_bright", mode, "color" }),

    surface_container_lowest = matchJSON(data, { "colors", "surface_container_lowest", mode, "color" }),
    surface_container_low = matchJSON(data, { "colors", "surface_container_low", mode, "color" }),
    surface_container = matchJSON(data, { "colors", "surface_container", mode, "color" }),
    surface_container_high = matchJSON(data, { "colors", "surface_container_high", mode, "color" }),
    surface_container_highest = matchJSON(data, { "colors", "surface_container_highest", mode, "color" }),

    surface_dim = matchJSON(data, { "colors", "surface_dim", mode, "color" }),
    surface_tint = matchJSON(data, { "colors", "surface_tint", mode, "color" }),

    on_surface = matchJSON(data, { "colors", "on_surface", mode, "color" }),

    inverse_surface = matchJSON(data, { "colors", "inverse_surface", mode, "color" }),
    inverse_on_surface = matchJSON(data, { "colors", "inverse_on_surface", mode, "color" }),

    surface_variant = matchJSON(data, { "colors", "surface_variant", mode, "color" }),
    on_surface_variant = matchJSON(data, { "colors", "on_surface_variant", mode, "color" }),

    outline = matchJSON(data, { "colors", "outline", mode, "color" }),
    outline_variant = matchJSON(data, { "colors", "outline_variant", mode, "color" }),
}
