package backend.cffi;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

/**
 * If you wish to learn how to utilize C++ with haxe:
 * https://github.com/snowkit/hxcpp-guide 
 */
class SpoopyCFFI {
    #if !html5
    private var spoopy_window_addon = new cpp.Callable<Int->Int>(cpp.Prime._loadPrime("spoopy", "hehe_funny", "ii", false));
    //public var spoopy_window_addon = Lib.load("spoopy", "hehe_funny", 1);
    #else
    public static function spoopy_window_addon(value:Int):Int {
        return 0;
    }
    #end
}