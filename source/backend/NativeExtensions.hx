package backend;

#if cpp
@:include("BackendHelper.cpp")
@:keep
@:native("feeshmora::BackendHelper")
#end
extern class NativeExtensions {
    #if cpp 
    @:native("feeshmora::BackendHelper::init")
    #end
	public static function init():Void;
}