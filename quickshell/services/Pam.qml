pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Pam

Singleton {
    readonly property PamContext context: (_context)

    PamContext {
        id: _context

        config: "login"

        property string text: ("")
        property bool lock: (false)
        property bool failed: (false)
        property bool isSuccessful: (false)

        onPamMessage: if (this.responseRequired) this.respond(this.text)
        onCompleted: result => {
        if (result == PamResult.Success)
        {
            this.isSuccessful = true
        }
        else
        {
            this.failed = true
        }
        this.text = ""
        this.isSuccessful = false
        this.failed = false
        this.lock = false}
    }

    readonly property var error: (PamError)
    readonly property var result: (PamResult)

    readonly property bool lock: (this.context.lock)
    readonly property bool failed: (this.context.failed)
    readonly property bool isSuccessful: (this.context.isSuccessful)

    function authenticate(password)
    {
        this.context.lock = true
        this.context.text = password
        this.context.start()
    }
}