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

class MenuSystem extends System
{
    private var engine:Engine;

    public function new()
    {
        super();
    }
    override public function addToEngine(_engine:Engine):Void
    {
        engine = _engine;

        var entity:Entity;

        entity = new Entity();
        entity.add(new Transform(new Vector3(0, 0, 0)));
        entity.add(new AnimatedSprite2D(Gengine.getResourceCache().getAnimationSet2D('menu.scml', true), "start"));
        entity.get(AnimatedSprite2D).setLayer(0);
        engine.addEntity(entity);
    }

    override public function update(dt:Float):Void
    {
        if(Gengine.getInput().getMouseButtonPress(1))
        {
            startGame();
        }

        if(Gengine.getInput().getScancodePress(41))
        {
            Gengine.exit();
        }
    }

    private function startGame()
    {
        engine.removeAllEntities();

        engine.addSystem(new AttackSystem(), 2);
        engine.addSystem(new GameSystem(), 3);
        engine.addSystem(new CollisionSystem(), 3);

        engine.removeSystem(this);
    }
}
