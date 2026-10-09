local colors = require((debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./") .. "colors/colors.lua")

return {
    colors = colors
}
