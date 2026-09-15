import Quickshell 
import "layers" as Layers
import "top" as Top
import qs.angulia.theme

ShellRoot {
    Layers.ExclusiveZones {
        exclusiveZones: _edge.edge + 20
        topExclusiveZone: exclusiveZones + 0
        leftExclusiveZone: exclusiveZones + 0
        rightExclusiveZone: exclusiveZones + 0
        bottomExclusiveZone: exclusiveZones + 0
    }
    Layers.Background {}
    Layers.Bottom {}
    Layers.Top {
        Top.Edge {
            id: _edge
            edge: 10
            radius: 25
            color: Colors.surface
        }
    }
    Layers.Overlay {}
}