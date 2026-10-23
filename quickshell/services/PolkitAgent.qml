pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Polkit

Singleton {

    property bool isActive: (_polkitagent.isActive)
    property AuthFlow flow: (_polkitagent.flow)
    PolkitAgent { id: _polkitagent }

    function submit(password)
    {
        this.flow.submit(password)
    }
    function cancelAuthenticationRequest()
    {
        this.flow.cancelAuthenticationRequest
    }
}