pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Polkit

Singleton {

    property bool isActive: (_polkitagent.isActive)
    property AuthFlow flow: (_polkitagent.flow)
    property PolkitAgent polkitagent: (_polkitagent)
    property string placeholderText: ("")
    readonly property bool inputLock: (Pam.lock)

    PolkitAgent { id: _polkitagent }

    function submit(password)
    {
        Pam.authenticate(password)
        this.flow.submit(password)
        this.placeholderText = ""
    }
    function cancelAuthenticationRequest()
    {
        this.flow.cancelAuthenticationRequest()
        this.placeholderText = ""
    }
    readonly property bool failed: (Pam.failed)
    onFailedChanged: if (this.failed) this.placeholderText = "Password Incorrect"
}