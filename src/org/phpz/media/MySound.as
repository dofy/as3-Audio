package org.phpz.media 
{
	import flash.events.EventDispatcher;
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
	
	/**
     * ...
     * @author Seven Yu
     */
    public class MySound extends EventDispatcher 
    {
        
        private var _sound:Sound;
        
        private var _url:String = '';
        private var _auto:Boolean = false;
        
        public function MySound(url:String, auto:Boolean = true) 
        {
            _auto = auto;
            play(url);
        }
        
        public function play(url:String):void 
        {
            _url = url;
            
            var ur:URLRequest = new URLRequest(url);
            var lc:LoaderContext = new LoaderContext(true);
            
            _sound = new Sound(ur, lc);
        }
        
        public function get url():String 
        {
            return _url;
        }
        
    }

}