pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Notifications // for NotificationServer and NotificationUrgency

Singleton {
    readonly property NotificationServer server: (_server)
    readonly property int critical: (NotificationUrgency.Critical)
    NotificationServer {
        id: _server
        onNotification: notification => notification.tracked = true
    }
}