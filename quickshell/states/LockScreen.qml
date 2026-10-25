pragma Singleton
import Quickshell // for Singleton
import Quickshell.Io
import "../services"

Singleton {
    id: _
    readonly property IpcHandler ipc: (_ipc)

    property bool open: (false)
    property string placeholderText: ("")
    readonly property bool inputLock: (Pam.lock)

    IpcHandler {
        id: _ipc
        target: "lockscreen"
        function lock()
        {
            _.open = true
        }
    }

    readonly property bool isSuccessful: (Pam.isSuccessful)
    readonly property bool failed: (Pam.failed)
    onIsSuccessfulChanged: if (this.isSuccessful) _.open = false
    onFailedChanged: if (this.failed) _.placeholderText = "Password Incorrect"

    function authenticate(password)
    {
        Pam.authenticate(password)
    }
}