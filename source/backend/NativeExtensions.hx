package backend;

#if !display
@:build(macros.FeshMacro.cppXML("source/backend/build_cpp.xml", ["source/backend"]))
@:include("BackendHelper.cpp")
@:unreflective
@:native("feeshmora::BackendHelper")
#end
@:keep
extern class NativeExtensions {
    #if !display
    @:native("feeshmora::BackendHelper::init")
    #end
	public static function init():Void;
}