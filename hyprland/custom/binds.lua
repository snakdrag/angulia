local function binds_create(keys, cmd, flags)
    if type(keys) == "table" then
        for _, key in ipairs(keys) do
            hl.bind(key, cmd, flags)
        end
    elseif type(keys) == "string" then
        hl.bind(keys, cmd, flags)
    end
end


local mouse_action = {
    up = "mouse_up",
    down = "mouse_down",
    left = "mouse:272",
    right = "mouse:273",
}

---------
-- app --
---------

binds_create("SUPER + T", hl.dsp.exec_cmd("kitty"))
binds_create("SUPER + E", hl.dsp.exec_cmd("nautilus"))
binds_create("SUPER + W", hl.dsp.exec_cmd("flatpak run com.brave.Browser"))
binds_create("SUPER + D", hl.dsp.exec_cmd("flatpak run dev.vencord.Vesktop"))
binds_create("SUPER + C", hl.dsp.exec_cmd("distrobox-enter -n fedora -- code"))
binds_create("SUPER + P", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
binds_create("SUPER + R", hl.dsp.exec_cmd(
    'pkill wf-recorder && notify-send "Recording Done!" "saved as ~/Videos/Recording_$(date +"%Y-%m-%d_%H-%M-%S").mp4" || ' ..
    '(notify-send "Recording..." && wf-recorder --audio -f ~/Videos/$(date +"%Y-%m-%d_%H-%M-%S").mp4)'
))
-- grim
-- slurp
-- wl-clipboard
-- wf-recorder

return {
    create = binds_create,
    quickshell = {
        launcher = "SUPER + A",
        lock = "SUPER + L",
        wallpaperswitcher = "SUPER + S",
    },
    session = {
        logout = "SUPER + M",
    },
    window = {
        close = "SUPER + Q",
        float = "SUPER + ALT + F",
        fullscreen = "SUPER + F",
        focuses = {
            up = "SUPER + up",
            down = "SUPER + down",
            left = "SUPER + left",
            right = "SUPER + right",
        },
        moves = {
            up = "SUPER + SHIFT + up",
            down = "SUPER + SHIFT + down",
            left = "SUPER + SHIFT + left",
            right = "SUPER + SHIFT + right",
        },
        drag = "SUPER + " .. mouse_action.left,
        resize = "SUPER + " .. mouse_action.right,
    },
    workspace = {
        focuses = {
            next = { "SUPER + " .. mouse_action.down, "SUPER + CTRL + RIGHT" },
            last = { "SUPER + " .. mouse_action.up, "SUPER + CTRL + LEFT" },
            normal = "SUPER + CTRL + down",
            special = "SUPER + CTRL + up",
            _1 = "SUPER + 1",
            _2 = "SUPER + 2",
            _3 = "SUPER + 3",
            _4 = "SUPER + 4",
            _5 = "SUPER + 5",
            _6 = "SUPER + 6",
            _7 = "SUPER + 7",
            _8 = "SUPER + 8",
            _9 = "SUPER + 9",
            _10 = "SUPER + 0",
        },
        moves = {
            next = "SUPER + SHIFT + CTRL + RIGHT",
            last = "SUPER + SHIFT + CTRL + LEFT",
            normal = "SUPER + CTRL + SHIFT + down",
            special = "SUPER + CTRL + SHIFT + up",
            _1 = "SUPER + SHIFT + 1",
            _2 = "SUPER + SHIFT + 2",
            _3 = "SUPER + SHIFT + 3",
            _4 = "SUPER + SHIFT + 4",
            _5 = "SUPER + SHIFT + 5",
            _6 = "SUPER + SHIFT + 6",
            _7 = "SUPER + SHIFT + 7",
            _8 = "SUPER + SHIFT + 8",
            _9 = "SUPER  + SHIFT + 9",
            _10 = "SUPER + SHIFT + 0",
        },
    },
}
