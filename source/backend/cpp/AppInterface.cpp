#include <hxcpp.h>
#include <iostream>

/**
 * @brief static method holder.
 * 
 * @author Just-Feeshy
 */
namespace spoopy {
    static void initialize_application_rendering() {
        std::cout << "hehe" << std::endl;

        #ifdef ENABLED_GLAD
        std::cout << "hehe double" << std::endl;
        #endif
    }
}