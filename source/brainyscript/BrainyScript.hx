package brainyscript;

import brainyscript.*;

class BrainyScript
{
    public var types:Map<String, BrainyScriptType> = new Map();
    
    public function new() {}

    private function error(line:Int, error:String)
    {
        Sys.println('ERROR at Line $line: $error');
    }

    public function execute(code:String)
    {
        var codeArray:Array<String> = code.split(';');

        var line = 1;
        for (code in codeArray)
        {
            switch(code)
            {
                default:
                    error(line, 'Unknown command.');
            }

            line ++;
        }
    }
}