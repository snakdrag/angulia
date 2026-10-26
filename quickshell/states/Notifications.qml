pragma Singleton
import QtQuick // for QtObject
import Quickshell // for Singleton
import "../services" as Services

Singleton {

    readonly property var server: (Services.Notifications.server)
    readonly property QtObject trackedNotifications: (this.server.trackedNotifications)

    readonly property var urgency: (Services.Notifications.urgency)
    readonly property var closeReason: (Services.Notifications.closeReason)

}