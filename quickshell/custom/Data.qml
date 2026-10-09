pragma Singleton
import Quickshell // for Singleton
import "../../settings" as S

Singleton {
    readonly property var settings: (S.Settings)
}