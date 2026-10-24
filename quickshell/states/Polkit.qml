pragma Singleton
import Quickshell // for Singleton
import "../services"

Singleton {

    property string placeholderText: ("")
    readonly property bool inputLock: (Polkit.lock)

    readonly property var agent: (Polkit.agent)
    readonly property var flow: (Polkit.flow)

    readonly property bool failed: (Polkit.failed)
    onFailedChanged: if (this.failed) {Polkit.agent.lock = false; this.placeholderText = "Password Incorrect"}

    function submit(password)
    {
        this.placeholderText = ""
        Polkit.submit(password)
    }
    function cancelAuthenticationRequest()
    {
        this.placeholderText = ""
        Polkit.cancelAuthenticationRequest()
    }
}