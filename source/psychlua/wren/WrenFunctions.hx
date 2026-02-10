package psychlua.wren;

import cpp.RawPointer;
import cpp.ConstCharStar;
import psychlua.wren.bindings.*;

/*
class WrenFunctions
{
    public static function bindForeignMethod(
        vm:RawPointer<WrenVM>,
        module:ConstCharStar,
        className:ConstCharStar,
        isStatic:Bool,
        signature:ConstCharStar
    ):WrenForeignMethodFn
    {
        // Return the actual native method function
        return exampleMethod;
    }

    public static function exampleMethod(
        vm:RawPointer<WrenVM>
    ):Void
    {
        Sys.println("Hello from exampleMethod!");
    }

    public static function bindForeignClass(
        vm:RawPointer<WrenVM>,
        module:ConstCharStar,
        className:ConstCharStar
    ):WrenForeignClassMethods
    {
        return {
            allocate: allocate,
            finalize: finalize
        };
    }

    public static function allocate(
        vm:RawPointer<WrenVM>
    ):Void
    {
        Sys.println("Allocating foreign class instance");
    }


    public static function finalize(
        vm:RawPointer<WrenVM>
    ):Void
    {
        Sys.println("Finalizing foreign class instance");
    }
}
/*