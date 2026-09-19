---------------------
---- KEYBINDINGS ----
---------------------

local binds = require("~/.config/quickshell/angulia/hyprland/settings/binds")

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mouse = { mouse = true }
local locked = { locked = true }
local repeating = { repeating = true }
local locked_repeating = { locked = true, repeating = true }

----------------
-- quickshell --
----------------

binds.create("SUPER + R", hl.dsp.exec_cmd("qs ipc call launcher toggle"))


-------------
-- session --
-------------

local logoutCmd = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
local lockCmd = ""

binds.create(binds.session.logout, hl.dsp.exec_cmd(logoutCmd))
binds.create(binds.session.lock, hl.dsp.exec_cmd(lockCmd))


------------
-- window --
------------

binds.create(binds.window.close, hl.dsp.window.close())
binds.create(binds.window.float, hl.dsp.window.float({ action = "toggle" }))
binds.create(binds.window.fullscreen, hl.dsp.window.fullscreen())

-- Move focus with mainMod + arrow keys
binds.create(binds.window.focuses.up, hl.dsp.focus({ direction = "up" }))
binds.create(binds.window.focuses.down, hl.dsp.focus({ direction = "down" }))
binds.create(binds.window.focuses.left, hl.dsp.focus({ direction = "left" }))
binds.create(binds.window.focuses.right, hl.dsp.focus({ direction = "right" }))

binds.create(binds.window.moves.up, hl.dsp.window.move({ direction = "up" }))
binds.create(binds.window.moves.down, hl.dsp.window.move({ direction = "down" }))
binds.create(binds.window.moves.left, hl.dsp.window.move({ direction = "left" }))
binds.create(binds.window.moves.right, hl.dsp.window.move({ direction = "right" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
binds.create(binds.window.drag, hl.dsp.window.drag(), mouse)
binds.create(binds.window.resize, hl.dsp.window.resize(), mouse)


---------------
-- workspace --
---------------

binds.create(binds.workspace.focuses._1, hl.dsp.focus({ workspace = 1 }))
binds.create(binds.workspace.focuses._2, hl.dsp.focus({ workspace = 2 }))
binds.create(binds.workspace.focuses._3, hl.dsp.focus({ workspace = 3 }))
binds.create(binds.workspace.focuses._4, hl.dsp.focus({ workspace = 4 }))
binds.create(binds.workspace.focuses._5, hl.dsp.focus({ workspace = 5 }))
binds.create(binds.workspace.focuses._6, hl.dsp.focus({ workspace = 6 }))
binds.create(binds.workspace.focuses._7, hl.dsp.focus({ workspace = 7 }))
binds.create(binds.workspace.focuses._8, hl.dsp.focus({ workspace = 8 }))
binds.create(binds.workspace.focuses._9, hl.dsp.focus({ workspace = 9 }))
binds.create(binds.workspace.focuses._0, hl.dsp.focus({ workspace = 10 }))

binds.create(binds.workspace.moves._1, hl.dsp.window.move({ workspace = 1 }))
binds.create(binds.workspace.moves._2, hl.dsp.window.move({ workspace = 2 }))
binds.create(binds.workspace.moves._3, hl.dsp.window.move({ workspace = 3 }))
binds.create(binds.workspace.moves._4, hl.dsp.window.move({ workspace = 4 }))
binds.create(binds.workspace.moves._5, hl.dsp.window.move({ workspace = 5 }))
binds.create(binds.workspace.moves._6, hl.dsp.window.move({ workspace = 6 }))
binds.create(binds.workspace.moves._7, hl.dsp.window.move({ workspace = 7 }))
binds.create(binds.workspace.moves._8, hl.dsp.window.move({ workspace = 8 }))
binds.create(binds.workspace.moves._9, hl.dsp.window.move({ workspace = 9 }))
binds.create(binds.workspace.moves._0, hl.dsp.window.move({ workspace = 10 }))

binds.create(binds.workspace.focuses.special, hl.dsp.workspace.toggle_special("magic"))
binds.create(binds.workspace.moves.special, hl.dsp.window.move({ workspace = "special:magic" }))

binds.create(binds.workspace.focuses.normal, hl.dsp.workspace.toggle_special("magic"))
binds.create(binds.workspace.moves.normal, hl.dsp.window.move({ workspace = "e+0" }))

-- Scroll through existing workspaces with mainMod + scroll
binds.create(binds.workspace.focuses.next, hl.dsp.focus({ workspace = "+1" }))
binds.create(binds.workspace.focuses.last, hl.dsp.focus({ workspace = "-1" }))
binds.create(binds.workspace.moves.next, hl.dsp.window.move({ workspace = "+1" }))
binds.create(binds.workspace.moves.last, hl.dsp.window.move({ workspace = "-1" }))


-- Laptop multimedia keys for volume and LCD brightness
binds.create("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), locked_repeating)
binds.create("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), locked_repeating)
binds.create("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked_repeating)
binds.create("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked_repeating)
binds.create("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), locked_repeating)
binds.create("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), locked_repeating)

-- Requires playerctl
binds.create("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
binds.create("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
binds.create("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
binds.create("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
