pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
 
Singleton {
    readonly property NotificationServer server: (_server)
    NotificationServer {
        id: _server
        onNotification: notification => notification.tracked = true
    }
}