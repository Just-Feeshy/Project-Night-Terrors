package;

import lime.system.System;

class Fesh {
    /**
    * Milliseconds of time per step of the game loop.
    */
    public static var stepPerMilliseconds(default, null):Float;

    /**
    * Seconds of time per step of the game loop.
    */
    public static var stepPerSeconds(default, null):Float;

    /**
    * How many times the game should to update each second.
    * Better framerates usually means better collisions and smoother motion. (Which is what I want.)
    */
    public static var framerate(default, set):Int = 60;

    /**
    * How many times the game should to step each second.
    * More steps USUALLY means greater responsiveness.
    */
    public static var stepFramerate(default, set):Int = 60;

    /**
    * WARNING: Changing this can lead to issues with the physics system.
    */
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

    /**
    * Total sceneries in application.
    */
    public static var sceneries(default, null):Array<Scene> = [];

    public static function attachGame(game:Game):Void {
        Fesh.game = game;
    }

    static function set_framerate(value:Int):Int {
        if(value < stepFramerate) {
            value = stepFramerate;
        }

        stepPerMilliseconds = Math.abs(1000 / value);
        stepPerSeconds = Math.abs(value / 1000);

        return framerate = value;
    }

    static function set_stepFramerate(value:Int):Int {
        if(value > framerate) {
            value = framerate;
        }

        return stepFramerate = value;
    }
}