package;

import lime.graphics.RenderContext;
import lime.app.Application;
import lime.ui.Window;

class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		game = new Game(FeshStates, #if debug false #else true #end);
		onCreateWindow.add(__initLimeEvents.bind());
	}

	private function __initLimeEvents(window:Window):Void {
		window.onActivate.add(__onLimeWindowActivate.bind(window));
		window.onResize.add(__onLimeWindowResize.bind(window));
		window.onRender.add(__onLimeRenderContext);
	}

	private function __onLimeWindowActivate(window:Window):Void {
		if(game != null) {
			game.init(window);
			
			game.resizeScene(window.width, window.height);
		}

		window.onActivate.remove(__onLimeWindowActivate.bind(window));
	}

	private function __onLimeWindowResize(window:Window, width:Int, height:Int):Void {
		if(game != null) {
			game.resizeScene(width, height);
		}
	}

	private function __onLimeRenderContext(context:RenderContext):Void {
		if(game != null) {
			game.eachFrame();
		}
	}
}