package;

class Game extends Scene {
    public function new(_state:Class<FeshStates>, fullscreen:Bool = true) {
        super(_state, fullscreen);

        Fesh.attachGame(this);
    }
}