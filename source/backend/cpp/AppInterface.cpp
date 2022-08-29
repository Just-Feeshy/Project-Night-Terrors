#include <hxcpp.h>
#include <iostream>

#ifdef ENABLED_SDL
#include <SDL.h>
#endif

#ifdef ENABLED_GLAD
//#include <>
#endif

/**
 * @brief static method holder.
 * 
 * @author Just-Feeshy
 */
namespace spoopy {
    static void initialize_application_rendering() {
        std::cout << "hehe" << std::endl;

        #ifdef ENABLED_SDL && ENABLED_GLAD

        #endif
    }
}