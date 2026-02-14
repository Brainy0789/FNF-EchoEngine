package debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.Font;
import openfl.system.System;
import openfl.filters.GlowFilter;
import haxe.Timer;

@:font("assets/fonts/vcr.ttf") 
class VCRFont extends Font {}

class FPSCounter extends TextField
{
    public var currentFPS(default, null):Int;
    public var totalFPS(default, null):Int;
    public var averageFPS(default, null):Float;
    public var memoryMegas(get, never):Float;
    public var maxMemory(default, null):Float;
    public var i(default, null):Int;

    public var minFPS:Float = 999;
    public var maxFPS:Float = 0;
    public var frameTime:Float = 0;

    @:noCompletion private var AVFPS:Array<Int>;
    @:noCompletion private var times:Array<Float>;

    // FPSType modes: 'Disabled', 'Enabled', 'Enabled + Memory', 'Enabled + Extra'
    private var _FPSType:String = "Enabled";
    public var FPSType(get, set):String;

    function get_FPSType():String
        return _FPSType;

    function set_FPSType(value:String):String
    {
        _FPSType = value;
        updateText(); // Immediately refresh display
        return value;
    }

    public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
    {
        super();

        Font.registerFont(VCRFont);

        this.x = x;
        this.y = y;

        selectable = false;
        mouseEnabled = false;
        defaultTextFormat = new TextFormat("vcr.ttf", 14, color);
        autoSize = LEFT;
        multiline = true;
        text = "FPS: ";

        currentFPS = 0;
        totalFPS = 0;
        averageFPS = 0;
        maxMemory = 0.0;
        AVFPS = [];
        times = [];
        i = 0;
    }

    var deltaTimeout:Float = 0.0;

    private override function __enterFrame(deltaTime:Float):Void
    {
        final now:Float = Timer.stamp() * 1000;
        times.push(now);
        while (times[0] < now - 1000) times.shift();

        frameTime = deltaTime;

        if (deltaTimeout < 50)
        {
            deltaTimeout += deltaTime;
            return;
        }

        currentFPS = Std.int(Math.min(times.length, FlxG.updateFramerate));
        AVFPS.push(currentFPS);

        if (currentFPS < minFPS) minFPS = currentFPS;
        if (currentFPS > maxFPS) maxFPS = currentFPS;

        totalFPS = 0;
        i = 0;
        for (v in AVFPS)
        {
            totalFPS += v;
            i++;
        }
        averageFPS = totalFPS / i;

        updateText();
        deltaTimeout = 0.0;
    }

    public dynamic function updateText():Void
	{
		var mode:Bool = ClientPrefs.data.showFPS;
		//var mode:String = "Enabled + Extra";
		if (!mode)
		{
			visible = false;
			return;
		}

		visible = true;

		if (memoryMegas > maxMemory)
			maxMemory = memoryMegas;

		var output = 'FPS: ${currentFPS}/${ClientPrefs.data.framerate}';
		output += '\nMemory Usage: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}/${flixel.util.FlxStringUtil.formatBytes(maxMemory)}';

		text = output;

		textColor = 0xFFFFFFFF;
		if (currentFPS < FlxG.drawFramerate * 0.5)
			textColor = 0xFFFF0000;
		
		filters = [new GlowFilter(0x000000, 1, 10, 10, 10, 1, true, false)];

	}


    inline function get_memoryMegas():Float
        return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
}