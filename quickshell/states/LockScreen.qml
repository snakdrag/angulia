pragma Singleton
import Quickshell // for Singleton
import Quickshell.Io
import "../services" as Services

Singleton {
    id: _
    readonly property IpcHandler ipc: (_ipc)

    property bool open: (false)
    property string placeholderText: ("")
    readonly property bool inputLock: (Services.Pam.lock)

    IpcHandler {
        id: _ipc
        target: "lockscreen"
        function lock()
        {
            _.open = true
        }
    }

    readonly property bool isSuccessful: (Services.Pam.isSuccessful)
    readonly property bool failed: (Services.Pam.failed)
    onIsSuccessfulChanged: if (this.isSuccessful) _.open = false
    onFailedChanged: if (this.failed) _.placeholderText = "Password Incorrect"

    function authenticate(password)
    {
        Services.Pam.authenticate(password)
    }
}