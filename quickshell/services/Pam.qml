pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Pam

Singleton {
    id: _
    property bool lock: (false)

    property bool isSuccessful: (false)
    property bool failed: (false)
    readonly property PamContext pam: (_pam)

    function authenticate(password)
    {
        this.lock = true
        _pam.text = password
        _pam.start()
    }
    PamContext {
        id: _pam
        config: "login"
        property string text: ("")

        onPamMessage: {
            if (this.responseRequired)
            {
                this.respond(text)
            }
        }

        onCompleted: result => {
        if (result == PamResult.Success)
        {
            _.isSuccessful = true
        }
        else
        {
            _.failed = true
        }
        this.text = ""
        _.isSuccessful = false
        _.failed = false
        _.lock = false}
    }
}