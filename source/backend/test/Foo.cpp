#include <hx/CFFI.h>
#include <iostream>

value CPP_ForeignFunction(value haxeVal) {
    std::cout << haxeVal << std::endl;
    return haxeVal;
}

DEFINE_PRIM(CPP_ForeignFunction, 1);