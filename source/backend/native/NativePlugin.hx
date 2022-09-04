package backend.native;

@:include("ExternalInterface.cpp")
class NativePlugin {
    public static var lime_test = cpp.Lib.load("foo", "CPP_ForeignFunction", 1);
}