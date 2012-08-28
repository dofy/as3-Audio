package org.phpz.utils
{
    
    /**
     * FlashVars 公共类
     * @author Seven Yu
     */
    public class FlashVars
    {
        
        private static var _data:Object = {};
        
        public static function set data(value:Object):void
        {
            _data = value;
        }
        
        public static function attr(key:String, defaultValue:* = null):*
        {
            return _data[key] || defaultValue;
        }
    
    }

}