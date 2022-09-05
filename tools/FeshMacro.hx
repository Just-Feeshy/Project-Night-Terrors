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
    ENABLED_GLAD;
    ENABLED_SDL;
    ENABLED_APP;
}

/*
* A helper class with macros 'n stuff.
*/
class FeshMacro {
    public static function setupDefs() {
        #if (haxe_ver < "4.0.0")
        Context.fatalError('Unsupported Haxe version! Supported versions are 4.0.5 or newer! (Found: ${Context.definedValue("haxe_ver")}).', (macro null).pos);
        #end
        
        if(Context.defined("cpp") && !Context.defined("cppia")) {
            enableEnum(ENABLED_GLAD); //Change this in the future.

            enableEnum(ENABLED_SDL);
            enableEnum(ENABLED_APP);
        }
    }

    #if !display
    macro public static function setupMeta():Array<Field> {
        var curClass:Null<Ref<ClassType>> = Context.getLocalClass();
        var fields:Array<Field> = Context.getBuildFields();
        var newFields:Array<Field> = []; //If I wanna do field stuff.

        if(curClass == null) {
            return null;
        }

        for(m in curClass.get().meta.get()) {
            switch(m.name) {
                case ":setupGame":
                    if (Context.defined("cpp")) {
                        if (Reflect.hasField(m, "params")) {
                            newFields.push({
                                name: '__touch', pos: Context.currentPos(),
                                doc: null, meta: [], access: [APrivate, AStatic, AInline],
                                kind: FVar(macro : String, macro $v{ Std.string(Date.now().getTime())}),
                            });
                        }
                    }
            }
        }
        
        fields = fields.concat(newFields);
        return fields;
    }
    #end

    static inline function enableEnum(define:BuildEnums) {
        var def_String:String = Std.string(define);
        Compiler.define(def_String);
    }
}
#end