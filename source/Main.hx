package;

import lime.app.Application;
import backend.cffi.SpoopyCFFI;

import spoopy.ApplicationPlugin;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		ApplicationPlugin.init(this);

		game = new Game(Sandbox, #if debug false #else true #end);
		game.initFramerate(60, 60);
		onCreateWindow.add(game.initWindow.bind());
	}
}