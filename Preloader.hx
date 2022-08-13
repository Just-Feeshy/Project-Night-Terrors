package;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;

@:enum
abstract ExportType(String) to String from String {
    var TARGET = "target";
}

class Preloader {
    /**
    * It works lol.
    */
    public static function exportPath(type:String) {
        var export = "export/";

        #if windows
        export += "windows/";
        #elseif mac
        export += "mac/";
        #end

        #if debug
        export += "debug/";
        #elseif bit32
        export += "bit32/";
        #else
        export += "release/";
        #end

        switch(type) {
            case TARGET: {
                if (!Context.defined("export-path")) {
                    export += "project/";

                    #if cpp
                    export += "cpp/";
                    #end

                    Compiler.define("export-path", export);
                }
            }
        }
    }
}
#end