package backend;

#if !display
@:build(macros.FeshMacro.cppXML("source/backend/build_cpp.xml", ["source/backend", "libs/glad/include"]))
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