package;

import lime.app.Application;
import backend.cffi.SpoopyCFFI;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		//SpoopyCFFI.spoopy_window_addon.call(1);

		game = new Game(Sandbox, #if debug false #else true #end);
		game.initFramerate(60, 60);
		onCreateWindow.add(game.initWindow.bind());
	}
}