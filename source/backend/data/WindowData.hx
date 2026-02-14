package backend.data;

typedef WindowSize = {
    @:optional var width:Int;
    @:optional var height:Int;
}

typedef WindowData = 
{
    @:optional var title:String;
    @:optional var size:WindowSize;
}

class WindowDataHandler
{
    public static function getWindowData():WindowData
    {
        var path = Paths.json('windowData');
        var raw = '';
        try
        {
            raw = sys.io.File.getContent(path);
        }
        catch(e:Dynamic)
        {
            trace('Error getting Window Data!');
            return null;
        }
        
        return cast haxe.Json.parse(raw);
    }
}