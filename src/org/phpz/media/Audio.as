package org.phpz.media
{
    import flash.display.Sprite;
    import org.phpz.slib.utils.FlashVars;
    import org.phpz.slib.utils.JsProxy;
    import org.phpz.slib.utils.JSProxy;
    
    /**
     * ...
     * @author Seven Yu
     */
    public class Audio extends Sprite
    {
        
        private var mySound:MySound;
        
        public function Audio():void
        {
            init();
            bindEvents();
        }
        
        private function init():void
        {
            // init flash variables
            FlashVars.init(loaderInfo);
            
            // init jsProxy
            JSProxy.init(FlashVars.getParam('fn', 'fn'));
        }
        
        private function bindEvents():void
        {
        
        }
    }

}