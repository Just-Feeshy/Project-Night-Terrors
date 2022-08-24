package backend;

@:buildXml('<include name="../../../../source/backend/build_cpp.xml" />')
@:include("BackendHelper.cpp")
@:keep
@:native("feeshmora::BackendHelper")
extern class NativeExtensions {
    @:native("feeshmora::BackendHelper::init")
	public static function init():Void;
}