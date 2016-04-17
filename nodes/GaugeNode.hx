package nodes;

import ash.core.Node;
import components.*;
import gengine.components.*;

class GaugeNode extends Node<GaugeNode>
{
    public var transform:Transform;
    public var gauge:Gauge;
    public var sprite:StaticSprite2D;
}
