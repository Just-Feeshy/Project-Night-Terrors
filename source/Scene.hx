package;

import lime.graphics.RenderContext;
import lime.system.System;
import lime.ui.Window;

class Scene {
    public var width(default, null):Int = 0;
    public var height(default, null):Int = 0;

    public var elapsed(default, null):Float = 0;

    var _stateClass:Class<FeshStates>;

    var _state:FeshStates;

    var _openFullscreen:Bool;
    var _onFocusDebounce:Bool;

    var _startTime:Int = 0;

    var window:Window;

    var initialized:Bool = false;

    public function new(_stateClass:Class<FeshStates>, fullscreen:Bool = false) {
        this._stateClass = _stateClass;

        #if desktop
        this._openFullscreen = fullscreen;
        #end
    }

    public function update(elapsed:Float) {

    }

    public function init(window:Window):Void {
        initialized = true;

        _startTime = System.getTimer();
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
    }

    public function onFocusOut():Void {
        
    }

    public function initWindow(window:Window):Void {
        this.window = window;
        __initLimeEvents(window);
    }

    inline public function ticks():Float {
        if(initialized)
            return System.getTimer() - _startTime;
        else
            return 0;
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

	@:noCompletion private function __onLimeWindowResize(window:Window, width:Int, height:Int):Void {
        if (this.window != window || window == null) { 
            return;
        }

		resizeScene(width, height);
	}

	@:noCompletion private function __onLimeRenderContext(context:RenderContext):Void {
		if(Fesh.useFixedTimestep) {
            //elapsed = Fesh.timeScale * 
        }else {

        }

        update(elapsed);
	}

	@:noCompletion private function __onLimeWindowFocusIn(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		onFocusIn();
	}

	@:noCompletion private function __onLimeWindowFocusOut(window:Window):Void {
        if (this.window != window || window == null) { 
            return;
        }

		onFocusOut();
	}
}