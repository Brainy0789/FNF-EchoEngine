package psychlua.wren;

#if WREN_ALLOWED


//import psychlua.wren.WrenFunctions;

class FunkinWren
{
    public var wren:cpp.RawPointer<WrenVM>;
    public var config:WrenConfiguration;

    private static function writeFn(vm:cpp.RawPointer<WrenVM>, text:cpp.ConstCharStar):Void
	{
		if (cast(text, String) != "\n") 
			Sys.println(cast(text, String));
	}

    private static function errorFn(vm:cpp.RawPointer<WrenVM>, errorType:WrenErrorType, module:cpp.ConstCharStar, line:Int, msg:cpp.ConstCharStar):Void
	{
		switch (errorType)
		{
			case WREN_ERROR_COMPILE:
				Sys.println('[' + cast(module, String) + ' line ' + line + '] [Error] ' + cast(msg, String));
			case WREN_ERROR_STACK_TRACE:
				Sys.println('[' + cast(module, String) + ' line ' + line + '] in ' + cast(msg, String));
			case WREN_ERROR_RUNTIME:
				Sys.println('[Runtime Error] ' + cast(msg, String));
		}
	}

    public function new()
    {
        config = new WrenConfiguration();
		Wren.InitConfiguration(cpp.RawPointer.addressOf(config));
        config.writeFn = cpp.Function.fromStaticFunction(writeFn);
		config.errorFn = cpp.Function.fromStaticFunction(errorFn);

        //config.bindForeignMethodFn = psychlua.wren.WrenFunctions.bindForeignMethod;
        //config.bindForeignClassFn = psychlua.wren.WrenFunctions.bindForeignClass;

		wren = Wren.NewVM(cpp.RawPointer.addressOf(config));
    }

    public function execute(script:String)
    {
        switch (Wren.Interpret(wren, "main", File.getContent(Paths.wren("scripts/" + script))))
		{
			case WREN_RESULT_COMPILE_ERROR:
				Sys.println('Compile Error!');
			case WREN_RESULT_RUNTIME_ERROR:
				Sys.println('Runtime Error!');
			case WREN_RESULT_SUCCESS:
				Sys.println('Success!');
		}
    }
}
#end