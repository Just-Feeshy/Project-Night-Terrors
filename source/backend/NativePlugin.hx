package backend;

#if (!macro && (cpp && !cppia))
@:include("AppInterface.cpp")
@:native("spoopy")
#end
@:keep
extern class NativePlugin {
    #if (!macro && (cpp && !cppia))
    @:native("spoopy::initialize_application_rendering") public static function init():Void;
    #end
}