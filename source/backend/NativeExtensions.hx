package backend;

#if !display
@:include("BackendMain.cpp")
@:unreflective
@:native("feeshmora::BackendMain")
#end
@:keep
extern class NativeExtensions {
    #if !display
    @:native("feeshmora::BackendMain::init")
    #end
	public static function init():Void;
}