local modules = (
    (debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./") ..
    "modules/"
)
require(modules .. "monitors")
require(modules .. "autostart")
require(modules .. "env")
require(modules .. "permissions")
require(modules .. "decorations")
require(modules .. "misc")
require(modules .. "input")
require(modules .. "binds")
require(modules .. "rules")
