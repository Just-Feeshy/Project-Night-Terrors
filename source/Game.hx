package;

/**
* Main scenery class.
*/
class Game extends Scene {
    public function new(_state:Class<FeshStates>, fullscreen:Bool = true) {
        super(_state, fullscreen);

        Fesh.attachGame(this);
    }

    public function initFramerate(framerate:Int = 60, stepFramerate:Int = 60):Void {
        Fesh.framerate = framerate;
    }
}