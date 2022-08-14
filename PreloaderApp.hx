package;

import hxp.Path;
import hxp.System;

import sys.FileSystem;
import sys.io.File;

class PreloaderApp {

    /**
    * A lot of definitions.
    */
    private static function compile() {
        var scriptLayout:String = '-main Main\n\n-lib json2object' 
        #if hxcpp + "\n-lib hxcpp" #end
        + #if windows "\n-lib discord_rpc" #end
        + "\n\n";

        var export:String = "export/";

        scriptLayout += "-cp libs\n-cp source\n\n";

        #if windows
        export += "windows/";
        scriptLayout += "-D windows\n";
        #elseif mac
        export += "mac/";
        scriptLayout += "-D mac\n";
        #end

        #if debug
        var build:String = "debug";
        #elseif bit32
        var build:String = "bit32";
        #else
        var build:String = "release";
        #end

        export += build + "/";

        if(!FileSystem.exists("./export/haxe")) {
            FileSystem.createDirectory("./export/haxe");
        }

        #if desktop
        scriptLayout += "-D desktop\n\n";
        #elseif console
        scriptLayout += "-D console\n\n";
        #elseif mobile
        scriptLayout += "-D mobile\n\n";
        #end

        #if hxcpp
        scriptLayout += '-cpp ${Path.combine(Sys.getCwd(), export)}\n';
        #end

        #if debug
        scriptLayout += "\n-debug";
        #end

        File.saveContent('./export/haxe/${build}.hxml', scriptLayout);
        System.runCommand(Sys.getCwd() + "/source", "haxe", ['../export/haxe/${build}.hxml']);
    }

    public static function main():Void {
        compile();
    }
}