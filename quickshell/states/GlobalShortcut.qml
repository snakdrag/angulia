import Quickshell.Hyprland

GlobalShortcut {

    appid: "angulia"

    signal called()
    onPressed: Ipc.active = true
    onReleased: {
        if (Ipc.active)
        {
            this.called()
        }
        Ipc.active = false
    }
}