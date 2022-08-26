package macros;

import haxe.io.Path;

import haxe.macro.Expr;
import haxe.macro.Context;

//POSSIBILITY: Make my own metadata for this.

class FeshMacro {
    #if !display
    macro public static function cppXML(directory:String, dirDefs:Array<String>):Array<Field> {
        var curPos:Position = Context.currentPos();
        var curClass = Context.getLocalClass();

        var projectPath:String = "";

        for(i in 0...dirDefs.length) {
            projectPath = dirDefs[i];

            if(!Path.isAbsolute(projectPath)) {
                projectPath = Path.join([Sys.getCwd(), projectPath]);
            }

            projectPath = Path.normalize(projectPath);
            projectPath += '<set name="${dirDefs[i].split('/')[0].toUpperCase()}_DIR" value="${projectPath}/"/>\n';
        }

        if(projectPath.substr(projectPath.length - 2, projectPath.length) == "\n") {
            projectPath = projectPath.substr(0, projectPath.length - 2);
        }

        var getInclude:String = '<include name="../../../../${directory}" />';

        curClass.get().meta.add(":buildXml", [{expr:EConst(CString('$projectPath\n$getInclude')), pos: curPos}], curPos);
        return Context.getBuildFields();
    }
    #end
}