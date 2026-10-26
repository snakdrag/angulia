pragma Singleton
import Quickshell // for Singleton
import "../services" as Services

Singleton {

    readonly property bool open: (this.agent.isActive)

    property string placeholderText: ("")
    readonly property bool inputLock: (Services.Polkit.lock)

    readonly property var agent: (Services.Polkit.agent)
    readonly property var flow: (Services.Polkit.flow)

    readonly property bool failed: (Services.Polkit.failed)
    onFailedChanged: if (this.failed) {Services.Polkit.agent.lock = false; this.placeholderText = "Password Incorrect"}

    function submit(password)
    {
        this.placeholderText = ""
        Services.Polkit.submit(password)
    }
    function cancelAuthenticationRequest()
    {
        this.placeholderText = ""
        Services.Polkit.cancelAuthenticationRequest()
    }
}