package;

import lime.app.Application;

import spoopy.SpoopyEngine;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		SpoopyEngine.init();

		game = new Game(Sandbox, #if debug false #else true #end);
		game.initFramerate(60, 60);
		game.initWindow(this.window);
		onCreateWindow.add(game.initWindow.bind());

		if(game._renderer != null) {
			//trace("lmao");
			trace(game._renderer.windowTitle);
		}
	}
}