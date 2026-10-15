import Quickshell.Services.Pam

PamContext {
    id: _
    config: "login"
    property string text: ("")
    property bool lock: (false)

    signal succeeded()
    signal failed()

    function authenticate(password)
    {
        this.text = password
        this.lock = true
        this.start()
    }

    onPamMessage: {
        if (this.responseRequired)
        {
            this.respond(text)
        }
    }

    onCompleted: result => {
    if (result == PamResult.Success)
    {
        this.succeeded()
    }
    else
    {
        this.failed()
        this.text = ""
    }
    this.lock = false}
}