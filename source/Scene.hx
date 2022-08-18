package;

import lime.graphics.RenderContext;
import lime.system.System;
import lime.ui.Window;

import states.FeshStates;

class Scene {
    /**
    * How many times the game should to step each second.
    * More steps USUALLY means greater responsiveness.
    */
    public var stepFramerate(default, set):Int = 60;

    public var width(default, null):Int = 0;
    public var height(default, null):Int = 0;

    public var elapsed(default, null):Float = 0;

    /**
    * Whether the scene should be paused when focus is lost or not.
    */
    public var focusPause:Bool = true;

    /**
    * Store the amount of milliseconds since the last update loop.
    */
    var _accumulator:Float = 0;

    /**
    * Milliseconds that has passed.
    */
    var _tickCounter:Int = 0;

    /**
    * Total milliseconds that has passed.
    */
    var _averageDeltaTime:Int = 0;

    /**
    * Milliseconds of the last time step.
    */
    var _lastStepMilliseconds:Float = 0;

    var _stateClass:Class<FeshStates>;

    var _state:FeshStates;

    var _openFullscreen:Bool;
    var _onFocusDebounce:Bool;
    var _onLostFocus:Bool;
    
    var _startTime:Int = 0;

    var window:Window;

    public function new(_stateClass:Class<FeshStates>, fullscreen:Bool = false) {
        this._stateClass = _stateClass;

        #if desktop
        this._openFullscreen = fullscreen;
        #end
    }

    public function step():Void {
        if(Fesh.useFixedTimestep) {
            elapsed = Fesh.timeScale * Fesh.stepPerSeconds;
        }else {
            elapsed = Fesh.timeScale * (_lastStepMilliseconds / Fesh.fixedTimestep); //shitty timestep
        }

        update(elapsed);
    }

    public function update(elapsed:Float):Void {

    }

    public function init(window:Window):Void {
        _startTime = System.getTimer();
        _averageDeltaTime = ticks();

        resizeScene(window.width, window.height);

        #if desktop
        window.fullscreen = _openFullscreen;
        #end
    }

    public function onFocusIn():Void {
        #if (desktop && lime_legacy)
		if (!_onFocusDebounce) {
			_onFocusDebounce = true;
			return;
		}
		#end

        #if mobile
        resizeScene(window.width, window.height); //Just incase if I'mma make this mobile.
        #end

        _onLostFocus = false;
    }

    public function onFocusOut():Void {
        _onLostFocus = true;
    }

    public function initWindow(window:Window):Void {
        this.window = window;
        __initLimeEvents(window);
    }

    inline public function ticks():Int {
        return System.getTimer() - _startTime;
    }

    inline function resizeScene(width:Int, height:Int):Void {
        this.width = width;
        this.height = height;
    }

    @:noCompletion private function __initLimeEvents(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		window.onActivate.add(__onLimeWindowActivate.bind(window));
		window.onResize.add(__onLimeWindowResize.bind(window));
		window.onFocusIn.add(__onLimeWindowFocusIn.bind(window));
		window.onFocusOut.add(__onLimeWindowFocusOut.bind(window));
		window.onRender.add(__onLimeRenderContext);
	}

	@:noCompletion private function __onLimeWindowActivate(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		init(window);
		resizeScene(window.width, window.height);

		window.onActivate.remove(__onLimeWindowActivate.bind(window));
	}

	@:noCompletion function __onLimeWindowResize(window:Window, width:Int, height:Int):Void {
        if (this.window != window || window == null) { 
            return;
        }

		resizeScene(width, height);
	}

	@:noCompletion function __onLimeRenderContext(context:RenderContext):Void {
        _tickCounter = ticks();
        _lastStepMilliseconds = _tickCounter - _averageDeltaTime;
        _averageDeltaTime = _tickCounter;

        if(!_onLostFocus || !focusPause) {
            if(Fesh.useFixedTimestep) {
                _accumulator += _lastStepMilliseconds;

                if(_accumulator > Fesh.maxAccumulation) {
                    _accumulator = Fesh.maxAccumulation;
                }
                
                while(_accumulator >= Fesh.stepPerMilliseconds) {
                    step();

                    _accumulator -= Fesh.stepPerMilliseconds;
                }
            }else {
                step();
            }
        }
	}

	@:noCompletion function __onLimeWindowFocusIn(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		onFocusIn();
	}

	@:noCompletion function __onLimeWindowFocusOut(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		onFocusOut();
	}

    @:access(Fesh) inline function set_stepFramerate(value:Int):Int {
        if(value > Fesh.framerate) {
            value = Fesh.framerate;
            Log.warn("stepFramerate: should be less than or equals to Fesh.framerate.");
        }

        stepFramerate = Std.int(Math.abs(value));

        if(window != null) {
            window.frameRate = stepFramerate;
        }

        Fesh.maxAccumulation = (2 / Fesh.fixedTimestep) / stepFramerate - 1;
        Fesh.updateMaxAccumulation();

        return stepFramerate;
    }
}