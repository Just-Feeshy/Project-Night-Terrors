package;

import states.FeshStates;

/**
* Main scenery class.
*/
class Game extends Scene {
    @:allow(Fesh) var resetGame:Bool = false;

    public function new(_state:Class<FeshStates>, fullscreen:Bool = true) {
        focusPause = false;
        super(_state, fullscreen);

        Fesh.attachGame(this);
    }

    public function initFramerate(framerate:Int = 60, stepFramerate:Int = 60):Void {
        Fesh.framerate = framerate;
        this.stepFramerate = stepFramerate;
    }

    override public function step():Void {
        if(resetGame) {
            Fesh.reset();
            resetGame = false;
        }

        trace("oh");

        super.step();
    }
}