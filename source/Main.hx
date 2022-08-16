package;

import lime.app.Application;
import lime.ui.Window;

class Main extends Application {
	var game:Game;

	public function new() {
		super();

		game = new Game(FeshStates);
		onCreateWindow.add(__initLimeEvents.bind());
	}

	private function __initLimeEvents(window:Window):Void {
		window.onActivate.add(__onLimeWindowActivate.bind(window));
		window.onResize.add(__onLimeWindowResize.bind(window));
	}

	private function __onLimeWindowActivate(window:Window):Void {
		if(game != null) {
			game.init();
			
			game.resizeWindow(window.width, window.height);
		}

		window.onActivate.remove(__onLimeWindowActivate.bind(window));
	}

	private function __onLimeWindowResize(window:Window, width:Int, height:Int):Void {
		if(game != null) {
			game.resizeWindow(width, height);
		}
	}
}