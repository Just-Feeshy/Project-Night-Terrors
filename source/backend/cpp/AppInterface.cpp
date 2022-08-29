#include <hxcpp.h>
#include <iostream>

#ifdef ENABLED_SDL
#include <SDL.h>
#endif

#ifdef ENABLED_GLAD
#include <glad.c>
#endif

/**
 * @brief static method holder.
 * 
 * @author Just-Feeshy
 */
namespace spoopy {
    void initialize_application_rendering() {
        std::cout << "hehe 2.0" << std::endl;

        #ifdef ENABLED_SDL && ENABLED_GLAD
        
        #endif
    }
}