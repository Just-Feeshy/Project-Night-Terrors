package;

import lime.system.System;

class Fesh {
    public static var useFixedTimestep:Bool = true;

    /**
    * A framerate-independent interval that dictates when physics calculations are preformed.
    */
    public static var fixedTimestep:Float = 0.001;

    /**
    * The speed at which time progresses; default is `1.0`.
    */
	public static var timeScale:Float = 1;

    /**
    * The game object itself!
    */
    public static var game(default, null):Game;

    public static function attachGame(game:Game):Void {
        Fesh.game = game;
    }
}