package backend;

#if !display
@:include("BackendMain.cpp")
@:native("feeshmora::BackendMain")

@:structAccess
@:unreflective
#end
@:keep
extern class NativeExtensions {
    #if !display
    @:native("feeshmora::BackendMain::init")
    #end
	public static function init():Void;
}