package;

import lime.app.Application;
import lime.ui.Window;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		game = new Game(FeshStates, #if debug false #else true #end);
		onCreateWindow.add(game.initWindow.bind());
	}
}