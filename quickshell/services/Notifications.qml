pragma Singleton
import Quickshell // for Singleton
import Quickshell.Services.Notifications // for NotificationServer
 
Singleton {
    readonly property NotificationServer server: (_server)
    NotificationServer {
        id: _server
        onNotification: notification => notification.tracked = true
    }
}