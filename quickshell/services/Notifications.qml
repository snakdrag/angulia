pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Notifications

Singleton {
    readonly property NotificationServer server: (_server)

    NotificationServer {
        id: _server
        onNotification: notification => {
        notification.tracked = true}
    }

    readonly property var urgency: (NotificationUrgency)
    readonly property var closeReason: (NotificationCloseReason)
}