package;

import lime.system.System;
import lime.ui.Window;

class Scene {
    public var width(default, null):Int = 0;
    public var height(default, null):Int = 0;

    public var elapsed(default, null):Float = 0;

    var _state:Class<FeshStates>;
    var _openFullscreen:Bool;

    var _startTime:Int = 0;

    var window:Window;

    var initialized:Bool = false;

    public function new(_state:Class<FeshStates>, fullscreen:Bool = false) {
        this._state = _state;

        #if desktop
        this._openFullscreen = fullscreen;
        #end
    }

    public function eachFrame():Void {
        update(elapsed);
    }

    public function update(elapsed:Float) {

    }

    public function init(window:Window):Void {
        _startTime = System.getTimer();
        resizeScene(window.width, window.height);

        #if desktop
        window.fullscreen = _openFullscreen;
        #end
    }

    inline public function ticks():Float {
        if(initialized)
            return System.getTimer() - _startTime;
        else
            return 0;
    }

    @:allow(Main)
    inline function resizeScene(width:Int, height:Int):Void {
        this.width = width;
        this.height = height;
    }
}