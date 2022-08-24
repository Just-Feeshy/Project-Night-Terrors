package tools.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;

private enum BuildEnums {
    USING_GLAD;
}

class FeshMacro {
    public static function run() {
        #if (haxe_ver < "4.0.0")
        Context.fatalError('Unsupported Haxe version! Supported versions are 4.0.0 or newer! (Found: ${Context.definedValue("haxe_ver")}).', (macro null).pos);
        #end
        
        if(Context.defined("cpp")) { //Change this in the future.
            defineEnum(USING_GLAD);
        }
    }

    static inline function defineEnum(define:BuildEnums) {
        Compiler.define(Std.string(define));
    }
}