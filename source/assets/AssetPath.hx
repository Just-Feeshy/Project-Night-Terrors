package assets;

class AssetPath {
    @:noCompletion private var cachedText = new Map<String, String>();

    public static function getAsset<T:AssetType>(id:String, type:AssetType, shouldCache:Bool = true):T {
        if(shouldCache) {
            switch(type) {
                case TEXT:
                    Cache.cacheText();
                default:
                    return null;
            }
        }
    }
}