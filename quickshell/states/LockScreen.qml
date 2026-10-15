pragma Singleton
import Quickshell // for Singleton
import Quickshell.Io

Singleton {
    id: _
    property bool open: (false)
    property string placeholderText: ("")
    readonly property bool inputLock: (_pam.lock)

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
        _pam.authenticate(password)
    }
    Pam {
        id: _pam
        onSucceeded: _.open = false
        onFailed: _.placeholderText = "Password Incorrect"
    }
}