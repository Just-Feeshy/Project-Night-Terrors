package;

import lime.app.Application;
import backend.native.NativePlugin;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		game = new Game(Sandbox, #if debug false #else true #end);
		game.initFramerate(60, 60);
		onCreateWindow.add(game.initWindow.bind());
		
		//NativePlugin.initialize_application_rendering();
	}

	public function init():Void {
		
	}
}