package;

import hxp.Path;
import hxp.System;

import sys.FileSystem;
import sys.io.File;

import haxe.xml.Access;

class PreloaderApp {

    /**
    * A lot of definitions.
    */
    private static function compile() {
        var export = "export/";

        #if windows
        export += "windows/";
        #elseif mac
        export += "mac/";
        #end

        #if debug
        var build:String = "debug";
        #elseif bit32
        var build:String = "bit32";
        #else
        var build:String = "release";
        #end

        export += build + "/";

        #if (desktop || console || mobile)
        if(!FileSystem.exists("./export/haxe")) {
            FileSystem.createDirectory("./export/haxe");
        }

        #if desktop
        var device:String = "-D desktop";
        #elseif console
        var device:String = "-D console";
        #elseif mobile
        var device:String = "-D mobile";
        #end

        var initName:String = "InitializeApp";
        File.saveContent('./export/haxe/${initName}.hx', File.getContent('./tools/${initName}.hx'));
        File.saveContent('./export/haxe/${build}.hxml', '${device}\n\n-cp source\n-cp libs\n\n-main ${initName}\n-cpp ${export}');

        var cppDirectory:String = Path.combine(Sys.getCwd(), "export/hxml");

        System.runCommand(cppDirectory, "haxe", ['${build}.hxml']);
        #end
    }

    public static function main():Void {
        compile();
    }
}