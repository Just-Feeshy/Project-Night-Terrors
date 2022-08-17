package;

import lime.system.System;

class Fesh {
    public static var game(default, null):Game;

    public static function attachGame(game:Game):Void {
        Fesh.game = game;
    }
}
