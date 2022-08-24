package states;

interface IFeshStates {
    @:allow(Scene) var keepRendering(default, null):Bool;

    function onCreate():Void;
    function onDraw():Void;
    function onDestroy():Void;

    function onUpdate(elapsed:Float):Void;
}