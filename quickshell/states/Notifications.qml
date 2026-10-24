pragma Singleton
import QtQuick
import Quickshell // for Singleton
import "../services"

Singleton {

    readonly property var server: (Notifications.server)
    readonly property QtObject trackedNotifications: (this.server.trackedNotifications)

    readonly property var urgency: (Notifications.urgency)
    readonly property var closeReason: (Notifications.closeReason)

}