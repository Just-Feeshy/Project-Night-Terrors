package backend;

#if cpp
@:include("BackendHelper.cpp")
@:unreflective
@:native("feeshmora::BackendHelper")
#end
@:keep
extern class NativeExtensions {
    #if cpp 
    @:native("feeshmora::BackendHelper::init")
    #end
	public static function init():Void;
}