package;

import lime.app.Application;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		game = new Game(FeshStates, #if debug false #else true #end);
		game.initFramerate();
		onCreateWindow.add(game.initWindow.bind());
	}
}