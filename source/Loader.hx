package;

#if (neko || cppia)
import lime.system.CFFI;
#end

/**
 * If you wish to learn how to utilize C++ with haxe:
 * https://github.com/snowkit/hxcpp-guide 
 */
class Loader {
    static inline function loadNDLL(prim:String, signature:String):Dynamic {
        #if (neko || cppia)
        return CFFI.load("spoopy-engine", prim, signature.length, false);
        #elseif cpp
        return new cpp.Callable<Void->cpp.Object>(cpp.Prime._loadPrime("spoopy-engine", prim, signature, false));
        #end
    }
}