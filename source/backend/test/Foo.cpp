#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFIPrime.h>
#include <hx/CFFI.h>

#include <iostream>

namespace spoopy {
    int hehe_funny(int haxeValue) {
        std::cout << "haha funni" << std::endl;
        return 0;
    }
    DEFINE_PRIME1(hehe_funny);
}