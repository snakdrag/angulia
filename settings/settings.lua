local colors = require((debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./") .. "colors")

return {
    colors = colors
}
