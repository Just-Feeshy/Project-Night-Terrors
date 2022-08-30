package backend.native;

class NativePlugin {
    #if (!display && !macro)
    private static var initialize_application_rendering = null;
    #end
}