package backend;

@:keep
#if (!macro && (cpp && !cppia))
@:include("AppInterface.cpp")

@:setupPlugin([
    "source/backend",
	"libs",
	"tools/libs"
])
extern #end class NativePlugin {
    #if (!macro && (cpp && !cppia))
    @:native("spoopy::initialize_application_rendering") public static function initialize_application_rendering():Void;
    #end
}