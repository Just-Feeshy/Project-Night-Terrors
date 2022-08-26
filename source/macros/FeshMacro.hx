package macros;

import haxe.io.Path;

import haxe.macro.Expr;
import haxe.macro.Context;

using haxe.macro.PositionTools;

/**
* POSSIBILITY: Make my own metadata for this.
* A helper class with macros 'n stuff.
*/
class FeshMacro {
    #if !display
    /** 
    Adds a private internal inline static variable called __touch,
    which sets the value to the current time so that builds are always
    updated by the code, and native changes are dragged in automatically (except for header only changes) 
    *
    * Copied from linc. lol
    */
    macro public static function touch():Array<Field> {

        var _fields = Context.getBuildFields();

        _fields.push({
            name: '__touch', pos: Context.currentPos(),
            doc: null, meta: [], access: [APrivate, AStatic, AInline],
            kind: FVar(macro : String, macro $v{ Std.string(Date.now().getTime()) }),
        });

        return _fields;

    }

    macro public static function cppXML(directory:String, dirDefs:Array<String>):Array<Field> {
        var curPos:Position = Context.currentPos();
        var curClass = Context.getLocalClass();

        var projectPath:String = "";

        for(i in 0...dirDefs.length) {
            var sourcePath:String = dirDefs[i];

            if(!Path.isAbsolute(sourcePath)) {
                sourcePath = Path.join([Sys.getCwd(), sourcePath]);
            }

            sourcePath = Path.normalize(sourcePath);
            projectPath += '<set name="${dirDefs[i].split('/')[0].toUpperCase()}_DIR" value="${sourcePath}/"/>\n';
        }

        if(projectPath.substr(projectPath.length - 2, projectPath.length) == "\n") {
            projectPath = projectPath.substr(0, projectPath.length - 2);
        }

        var getInclude:String = '<include name="../../../../${directory}" />';

        var buildDir:String = '<set name ="BUILD_TARGET" value="glad"/>';

        curClass.get().meta.add(":buildXml", [{expr:EConst(CString('$buildDir\n$projectPath\n$getInclude')), pos: curPos}], curPos);
        return Context.getBuildFields();
    }
    #end
}