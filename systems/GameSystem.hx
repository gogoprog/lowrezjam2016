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

class GameSystem extends System
{
    private var engine:Engine;
    private var flyNodes:NodeList<FlyNode>;
    private var flyAnim = Gengine.getResourceCache().getAnimationSet2D('mosquito.scml', true);
    private var timer:Float = 0;
    private var border = 40;

    public function new()
    {
        super();
    }
    override public function addToEngine(_engine:Engine):Void
    {
        engine = _engine;
        flyNodes = engine.getNodeList(FlyNode);
        flyNodes.nodeAdded.add(onNodeAdded);
        flyNodes.nodeRemoved.add(onNodeRemoved);

        var entity:Entity;

        entity = new Entity();
        entity.add(new Transform(new Vector3(0, 0, 0)));
        entity.add(new AnimatedSprite2D(Gengine.getResourceCache().getAnimationSet2D('bg.scml', true), "light"));
        entity.get(AnimatedSprite2D).setLayer(0);
        engine.addEntity(entity);

        entity = new Entity();
        entity.add(new Transform(new Vector3(20, 10, 0)));
        entity.add(new AnimatedSprite2D(Gengine.getResourceCache().getAnimationSet2D('tail.scml', true), "idle"));
        entity.add(new Tail());
        entity.get(AnimatedSprite2D).setLayer(0);
        engine.addEntity(entity);

        entity = new Entity();
        entity.add(new Transform(new Vector3(0, 0, 0)));
        entity.add(new StaticSprite2D(Gengine.getResourceCache().getSprite2D('body.png', true)));
        entity.get(StaticSprite2D).setLayer(1);
        engine.addEntity(entity);

        entity = new Entity();
        entity.add(new Transform(new Vector3(-20, 10, 0)));
        entity.add(new AnimatedSprite2D(Gengine.getResourceCache().getAnimationSet2D('head.scml', true), "idle", 2));
        entity.add(new Head());
        entity.get(AnimatedSprite2D).setLayer(5);
        engine.addEntity(entity);
    }

    override public function update(dt:Float):Void
    {
        timer += dt;

        if(timer > 1.0)
        {
            spawnFly();
            timer = 0;
        }

        for(node in flyNodes)
        {
            if(!node.fly.catched)
            {
                var position = node.fly.position;
                var velocity = node.fly.velocity;

                if(position.x < - border)
                {
                    velocity.x = Math.random() * 20 + 5;
                }
                else if(position.x > border)
                {
                    velocity.x = Math.random() * - 20 - 5;
                }

                if(position.y < - border)
                {
                    velocity.y = Math.random() * 20 + 5;
                }
                else if(position.y > border)
                {
                    velocity.y = Math.random() * -20 - 5;
                }

                position.x += velocity.x * dt;
                position.y += velocity.y * dt;

                node.transform.setPosition(new Vector3(Math.floor(position.x), Math.floor(position.y), 0));

                var x = velocity.x / Math.abs(velocity.x);
                node.transform.setScale(new Vector3(x, 1, 1));
            }
        }

        if(Gengine.getInput().getScancodePress(41))
        {
            engine.removeAllEntities();
            engine.addSystem(new MenuSystem(), 2);
            engine.removeSystem(engine.getSystem(CollisionSystem));
            engine.removeSystem(engine.getSystem(AttackSystem));
            engine.removeSystem(this);
        }
    }

    private function spawnFly()
    {
        var e = new Entity();
        var position:Vector3 = new Vector3(0, 0, 0);

        if(Math.random() < 0.5)
        {
            position.x = Math.random() * 64 - 32;

            if(Math.random() < 0.5)
            {
                position.y = border;
            }
            else
            {
                position.y = -border;
            }
        }
        else
        {
            position.y = Math.random() * 64 - 32;

            if(Math.random() < 0.5)
            {
                position.x = border;
            }
            else
            {
                position.x = -border;
            }
        }

        e.add(new Transform(position));
        e.add(new Fly());
        e.add(new AnimatedSprite2D(flyAnim, "fly"));

        e.get(AnimatedSprite2D).setLayer(10);
        e.get(Fly).velocity = new Vector2(Math.random() * 20 - 10, Math.random() * 20 - 10);
        e.get(Fly).position = position;
        engine.addEntity(e);
    }

    private function onNodeAdded(node:FlyNode):Void
    {
    }

    private function onNodeRemoved(node:FlyNode):Void
    {
    }
}
