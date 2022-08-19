package;

import lime.app.Application;
import states.FeshStates;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		game = new Game(FeshStates, #if debug false #else true #end);
		game.initFramerate(60, 60);
		onCreateWindow.add(game.initWindow.bind());
	}
}
