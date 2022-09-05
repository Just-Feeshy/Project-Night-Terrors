package backend.native;

class NativePlugin {
    public static var lime_test = cpp.Lib.load("spoopy-engine", "CPP_ForeignFunction", 1);
}