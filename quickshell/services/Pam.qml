pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Pam

Singleton {

    readonly property PamContext context: (_context)
    readonly property var error: (PamError)
    readonly property var result: (PamResult)
    readonly property bool lock: (this.context.lock)
    readonly property bool failed: (this.context.failed)
    readonly property bool isSuccessful: (this.context.isSuccessful)

    PamContext {
        id: _context

        property string text: ("")
        property bool lock: (false)
        property bool failed: (false)
        property bool isSuccessful: (false)

        config: "login"

        onPamMessage: if (this.responseRequired) this.respond(this.text)
        onCompleted: result => {
        if (result == PamResult.Success) this.isSuccessful = true;
        if (result != PamResult.Success) this.failed = true
        this.text = ""
        this.isSuccessful = false
        this.failed = false
        this.lock = false}
    }

    function authenticate(password)
    {
        this.context.lock = true
        this.context.text = password
        this.context.start()
    }
}