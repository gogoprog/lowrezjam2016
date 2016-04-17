package systems;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import ash.core.*;

import gengine.nodes.*;
import gengine.components.*;
import gengine.Gengine;
import gengine.math.*;
import nodes.*;
import components.*;
import systems.*;

class GaugeSystem extends System
{
    private var engine:Engine;
    private var gaugeNode:GaugeNode;
    private var life:Float = 100;
    private var maxLife:Float = 100;

    public function new()
    {
        super();
    }

    override public function addToEngine(_engine:Engine):Void
    {
        engine = _engine;

        var entity:Entity;

        entity = new Entity();
        entity.add(new Transform(new Vector3(0, -30, 0)));
        entity.add(new Gauge());
        entity.add(new StaticSprite2D(Gengine.getResourceCache().getSprite2D('40.png', true)));
        entity.get(StaticSprite2D).setLayer(9);
        engine.addEntity(entity);
    }

    override public function update(dt:Float):Void
    {

    }

    public function gainLife(amount:Float)
    {
        life = Math.min(maxLife, life + amount);
    }

    public function loseLife(amount:Float)
    {
        life = Math.max(0, life - amount);
    }
}
