pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Polkit

Singleton {

    property PolkitAgent polkitagent: (_polkitagent)
    property AuthFlow flow: (this.polkitagent.flow)
    property bool isActive: (this.polkitagent.isActive)
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