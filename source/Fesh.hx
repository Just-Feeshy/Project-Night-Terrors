package;

class Fesh {
    /**
    * Maximum accumulation.
    */
	public static var maxAccumulation(default, null):Float;

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
    * WARNING: Changing this can lead to issues with the physics system.
    */
    public static var useFixedTimestep:Bool = true;

    /**
    * A framerate-independent interval that dictates when physics calculations are preformed.
    */
    public static var fixedTimestep:Float = 2000;

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

    public static inline function attachGame(game:Game):Void {
        Fesh.game = game;
    }

    /**
	 * Re-launch game.
	 */
	public static inline function resetGame():Void {
        trace("Reset");

        if(game != null) game.resetGame = true;
    }

    public static inline function updateMaxAccumulation():Void {
        if(maxAccumulation < stepPerMilliseconds) {
            maxAccumulation = stepPerMilliseconds;
        }
    }

    @:allow(Game) static inline function reset():Void {
        //Reset EVERYTHING
    }

    static inline function set_framerate(value:Int):Int {
        Log.info("Fesh.framerate: must be less than any scenes stepFramerate.");

        stepPerMilliseconds = Math.abs(1000 / value);
        stepPerSeconds = Math.abs(value / 1000);

        updateMaxAccumulation();

        return framerate = value;
    }
}