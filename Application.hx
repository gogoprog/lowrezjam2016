import ash.core.*;
import gengine.*;
import gengine.components.*;
import gengine.math.*;
import systems.*;
import components.*;

class Application
{
    public static var windowSize:IntVector2;
    public static function init()
    {
        trace("Application.init()");

        untyped __js__("
            if(typeof $ !== 'undefined') {
                this.windowSize = new Module.IntVector2(64, 64);
            }
            else {
                this.windowSize = new Module.IntVector2(640, 640);
            }
        ");

        Gengine.setWindowSize(windowSize);
        Gengine.setWindowTitle("Chamosqui - lowrezjam2016");
    }

    public static function start(engine:Engine)
    {
        trace("Application.start()");

        untyped __js__("
            if(typeof $ !== 'undefined') {
                $('#gui').remove();
                $('canvas').css('width', 320);
                $('canvas').css('height', 320);
                $('canvas').css('image-rendering', 'optimizeSpeed');
                $('canvas').css('image-rendering', '-moz-crisp-edges');
                $('canvas').css('image-rendering', '-webkit-optimize-contrast');
                $('canvas').css('image-rendering', '-o-crisp-edges');
                $('canvas').css('image-rendering', 'crisp-edges');
                $('canvas').css('image-rendering', 'pixelated');
                $('canvas').css('-ms-interpolation-mode', 'nearest-neighbor');
            }
        ");

        engine.addSystem(new MenuSystem(), 2);
    }
}
