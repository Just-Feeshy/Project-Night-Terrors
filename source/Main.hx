package;

import lime.app.Application;

import backend.NativeExtensions;

#if !display
@:build(macros.FeshMacro.touch())
@:build(macros.FeshMacro.cppXML("source/backend/cpp/build_cpp.xml", ["source/backend", "libs/glad/include"]))
#end
class Main extends Application {
	var game:Game; //Make da game itself.

	public function new() {
		super();

		init();

		game = new Game(Sandbox, #if debug false #else true #end);
		game.initFramerate(60, 60);
		onCreateWindow.add(game.initWindow.bind());
	}

	inline function init() {
		NativeExtensions.init();
	}
}
