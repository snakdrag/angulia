pragma Singleton
import Quickshell // for Singleton
import Quickshell.Io
import "../angulia"

Singleton {
    id: _
    property bool open: (false)
    readonly property Pam pam: (_pam)

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
        console.log("authenticate")
        _pam.authenticate(password)
    }
    Pam {
        id: _pam
        onSucceeded: _.open = false
        onFailed: {}
    }
}