package;

import states.IFeshStates;

/**
* Main scenery class.
*/

@:setupGame([
    "source/backend",
	"libs",
	"tools/libs",
    "project"
])

class Game extends Scene {
    @:allow(Fesh) var resetGame:Bool = false;

    public function new(_state:Class<IFeshStates>, fullscreen:Bool = true) {
        focusPause = false;
        super(_state, fullscreen);

        Fesh.attachGame(this);
    }

    public function initFramerate(framerate:Int = 120, stepFramerate:Int = 120):Void {
        Fesh.framerate = framerate;
        this.stepFramerate = stepFramerate;
    }

    override public function step():Void {
        if(resetGame) {
            Fesh.reset();
            resetGame = false;
        }

        super.step();
    }
}