package backend;

#if cpp
@:buildXml('<include name="../../../../source/backend/build_cpp.xml" />')
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