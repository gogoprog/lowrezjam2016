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
    private var life:Float = 20;
    private var maxLife:Float = 20;
    private var steps = [5, 10, 15, 20, 25, 30, 35, 40];

    public function new()
    {
        super();
    }

    override public function addToEngine(_engine:Engine):Void
    {
        engine = _engine;
        engine.getNodeList(GaugeNode).nodeAdded.add(onNodeAdded);

        var entity:Entity;

        entity = new Entity();
        entity.add(new Transform(new Vector3(0, -29, 0)));
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
        updateGauge();
    }

    public function loseLife(amount:Float)
    {
        life = Math.max(0, life - amount);
        updateGauge();
    }

    private function onNodeAdded(node:GaugeNode):Void
    {
        gaugeNode = node;
    }

    private function updateGauge()
    {
        var value = life / maxLife;
        value *= steps.length;
        value = Math.min(value, steps.length - 1);
        value = Math.max(value, 0);
        value = Math.floor(value);

        gaugeNode.sprite.setSprite(Gengine.getResourceCache().getSprite2D(steps[cast(value, Int)] + '.png', true));
    }
}
