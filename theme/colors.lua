local f = assert(
    io.open(
        (debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./") .. "colors.json",
        "r"
    )
)
local data = f:read("*a")
f:close()

local mode = data:match('"mode"%s*:%s*"([^"]+)"')

local function get_color(name)
    local pattern = (
        '"colors"%s*:%s*{%s*.-"' ..
        name .. '"%s*:%s*{%s*.-"' ..
        mode .. '"%s*:%s*{%s*"color"%s*:%s*"([^"]+)"'
    )
    return data:match(pattern)
end

return {
    primary = get_color("primary"),
    on_primary = get_color("on_primary"),
    primary_container = get_color("primary_container"),
    on_primary_container = get_color("on_primary_container"),

    secondary = get_color("secondary"),
    on_secondary = get_color("on_secondary"),
    secondary_container = get_color("secondary_container"),
    on_secondary_container = get_color("on_secondary_container"),

    tertiary = get_color("tertiary"),
    on_tertiary = get_color("on_tertiary"),
    tertiary_container = get_color("tertiary_container"),
    on_tertiary_container = get_color("on_tertiary_container"),

    error = get_color("error"),
    on_error = get_color("on_error"),
    error_container = get_color("error_container"),
    on_error_container = get_color("on_error_container"),

    background = get_color("background"),
    on_background = get_color("on_background"),

    surface = get_color("surface"),
    surface_bright = get_color("surface_bright"),

    surface_container_lowest = get_color("surface_container_lowest"),
    surface_container_low = get_color("surface_container_low"),
    surface_container = get_color("surface_container"),
    surface_container_high = get_color("surface_container_high"),
    surface_container_highest = get_color("surface_container_highest"),

    surface_dim = get_color("surface_dim"),
    surface_tint = get_color("surface_tint"),

    on_surface = get_color("on_surface"),

    inverse_surface = get_color("inverse_surface"),
    inverse_on_surface = get_color("inverse_on_surface"),

    surface_variant = get_color("surface_variant"),
    on_surface_variant = get_color("on_surface_variant"),

    outline = get_color("outline"),
    outline_variant = get_color("outline_variant"),
}
