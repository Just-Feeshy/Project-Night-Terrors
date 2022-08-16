package;

import lime.system.System;

class Game {
    var _state:Class<FeshStates>;

    var _startTime:Int = 0;

    var initialized:Bool = false;

    var width:Int = 0;
    var height:Int = 0;

    public function new(width:Int = 0, height:Int = 0, _state:Class<FeshStates>) {
        this._state = _state;
    }

    public function init():Void {
        initialized = true;

        trace("hehe");
    }

    inline public function ticks():Float {
        if(initialized)
            return System.getTimer() - _startTime;
        else
            return 0;
    }

    @:allow(Main)
    inline function resizeWindow(width:Int, height:Int):Void {
        this.width = width;
        this.height = height;
    }
}