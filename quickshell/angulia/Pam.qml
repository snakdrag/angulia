import Quickshell.Services.Pam

PamContext {
    id: _
    config: "login"
    property string text: ("")

    signal succeeded()
    signal failed()

    function authenticate(password)
    {
        text = password
        start()
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
        succeeded()
    }
    else
    {
        failed()
        text = ""
    }}
}