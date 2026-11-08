pragma Singleton
import Quickshell // for Singleton
import Quickshell.Io
import "../services" as Services

Singleton {
    id: _

    property bool open: (false)
    property string placeholderText: ("")
    readonly property IpcHandler ipc: (_ipc)
    readonly property bool inputLock: (Services.Pam.lock)
    readonly property bool isSuccessful: (Services.Pam.isSuccessful)
    readonly property bool failed: (Services.Pam.failed)

    onIsSuccessfulChanged: if (this.isSuccessful) _.open = false
    onFailedChanged: if (this.failed) _.placeholderText = "Password Incorrect"

    IpcHandler {
        id: _ipc

        target: "lockscreen"

        function lock()
        {
            _.open = true
        }
    }

    function authenticate(password)
    {
        Services.Pam.authenticate(password)
    }
}