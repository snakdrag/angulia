pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Polkit

Singleton {

    readonly property PolkitAgent agent: (_agent)
    readonly property AuthFlow flow: (this.agent.flow)
    readonly property bool lock: (this.agent.lock)
    readonly property bool failed: (this.flow === null ? false: this.flow.failed)
    readonly property bool isSuccessful: (this.flow === null ? false: this.flow.isSuccessful)

    PolkitAgent {
        id: _agent

        property bool lock: (false)
    }

    function submit(password)
    {
        this.agent.lock = true
        this.flow.submit(password)
    }
    function cancelAuthenticationRequest()
    {
        this.flow.cancelAuthenticationRequest()
        this.agent.lock = false
    }
}