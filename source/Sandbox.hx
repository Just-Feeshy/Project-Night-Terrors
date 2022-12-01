package;

import states.IFeshStates;

class Sandbox implements IFeshStates {
    public var keepRendering(default, null):Bool = true;

    public function onCreate():Void {
        //@:privateAccess trace(Fesh.game._renderer.windowTitle);
    }

    public function onUpdate(elapsed:Float):Void {

    }

    public function onDraw():Void {
        
    }

    public function onDestroy():Void {

    }
}