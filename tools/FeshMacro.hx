package tools;

import haxe.io.Path;

#if macro //Obviously
import haxe.macro.Expr;
import haxe.macro.Compiler;
import haxe.macro.Context;

#if !display
import haxe.macro.Type.Ref;
import haxe.macro.Type.ClassType;
import haxe.macro.Type.TInst;

using haxe.macro.PositionTools;
using haxe.macro.ExprTools;
#end

private enum BuildEnums {
    USING_GLAD;
}

/*
* A helper class with macros 'n stuff.
*/
class FeshMacro {
    public static function setupDefs() {
        #if (haxe_ver < "4.0.0")
        Context.fatalError('Unsupported Haxe version! Supported versions are 4.0.0 or newer! (Found: ${Context.definedValue("haxe_ver")}).', (macro null).pos);
        #end
        
        if(Context.defined("cpp")) { //Change this in the future.
            defineEnum(USING_GLAD);
        }
    }

    #if !display
    static var CPP_DIR:String = "source/backend/cpp/build_cpp.xml";
    static var GAME_INIT:Bool = false;

    /** 
    Adds a private internal inline static variable called __touch,
    which sets the value to the current time so that builds are always
    updated by the code, and native changes are dragged in automatically (except for header only changes) 
    *
    * Copied from linc. lol
    */
    macro public static function touch():Array<Field> {
        var _fields:Array<Field> = Context.getBuildFields();

        _fields.push({
            name: '__touch', pos: Context.currentPos(),
            doc: null, meta: [], access: [APrivate, AStatic, AInline],
            kind: FVar(macro : String, macro $v{ Std.string(Date.now().getTime()) }),
        });

        return _fields;
    }

    public static function cppXML(directory:String, dirDefs:Array<String>):Array<Field> {
        var curPos:Position = Context.currentPos();
        var curClass:Null<Ref<ClassType>> = Context.getLocalClass();

        if(curClass == null) {
            return null;
        }

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
        var getBuildTarget:String = '<set name="ENABLED_GLAD" value="1"/>';

        curClass.get().meta.add(":buildXml", [{expr:EConst(CString('$getBuildTarget\n$projectPath\n$getInclude')), pos: curPos}], curPos);
        return Context.getBuildFields();
    }

    macro public static function setupMeta():Array<Field> {
        var curClass:Null<Ref<ClassType>> = Context.getLocalClass();
        var fields:Array<Field> = Context.getBuildFields();

        var META_STR:String = ":setupGame";

        if(curClass == null) {
            return null;
        }

        for(m in curClass.get().meta.extract(META_STR)) {
            if(m.name == ":setupGame") {
                if(GAME_INIT) {
                    continue;
                }

                if (Reflect.hasField(m, "params")) {
                    fields = cppXML("source/backend/cpp/build_cpp.xml", m.params[0].getValue());
                }

                GAME_INIT = true;
            }
        }
        
        return fields;
    }
    #end

    static inline function defineEnum(define:BuildEnums) {
        Compiler.define(Std.string(define));
    }
}
#end