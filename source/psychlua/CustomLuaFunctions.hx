package psychlua;

import openfl.Lib;

class CustomLuaFunctions
{
    private static function addMultiple(lua:State, funcs:Array<String>, func:Dynamic)
    {
        for (functionName in funcs)
        {
            Lua_helper.add_callback(lua, functionName, func);
        }
    }

    public static function implement(funk:FunkinLua)
    {
        var lua:State = funk.lua;

        Lua_helper.add_callback(lua, 'setWindowName', function(name:String) {
            Lib.current.stage.window.title = name;
        });

       addMultiple(lua, ['quit', 'exit', 'crash'], function(code:Int = 0) {Sys.exit(code);});

        Lua_helper.add_callback(lua, 'switchState', function(path:String, state:String) {
            var fullName = path + "." + state;
            var cls = Type.resolveClass(fullName);

            if (cls == null) {
                trace("State not found: " + fullName);
                return;
            }

            FlxG.switchState(cast cls);
        });

        Lua_helper.add_callback(lua, 'stringifyJson', function(data:Dynamic, format:String = ''){return haxe.Json.stringify(data, format);});
    }
}