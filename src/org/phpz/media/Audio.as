package org.phpz.media
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import org.phpz.media.events.AudioEvent;
    import org.phpz.slib.utils.FlashVars;
    import org.phpz.slib.utils.JSProxy;
    
    /**
     * ...
     * @author Seven Yu
     */
    public class Audio extends Sprite
    {
        
        private var mySound:MySound = new MySound();
        
        public function Audio():void
        {
            init();
            bindEvents();
            
            run();
        }
        
        private function init():void
        {
            // init flash variables
            FlashVars.init(loaderInfo);
            
            // init jsProxy
            JSProxy.init(FlashVars.getParam('fn', 'fn'));
            
            JSProxy.register('play', play);
            JSProxy.register('pause', pause);
            JSProxy.register('resume', resume);
            JSProxy.register('stop', stop);
            JSProxy.register('vol', vol);
            JSProxy.register('mute', mute);
            JSProxy.register('position', position);
        }
        
        private function play(url:String):void 
        {
            mySound.play(url);
        }
        
        private function pause():void 
        {
            mySound.pause();
        }
        
        private function resume():void 
        {
            mySound.resume();
        }
        
        private function stop():void 
        {
            mySound.stop();
        }
        
        private function vol(value:Number):void 
        {
            mySound.vol = value;
        }
        
        private function mute():void 
        {
            mySound.mute();
        }
        
        private function position(value:Number):void 
        {
            mySound.position = value;
        }
        
        private function bindEvents():void
        {
            mySound.addEventListener(AudioEvent.ON_START, handler);
            mySound.addEventListener(AudioEvent.ON_PAUSE, handler);
            mySound.addEventListener(AudioEvent.ON_VOL_CHANGED, handler);
            mySound.addEventListener(AudioEvent.ON_PROGRESS, handler);
            mySound.addEventListener(AudioEvent.ON_COMPLETE, handler);
        }
        
        private function handler(e:AudioEvent):void 
        {
            JSProxy.call(e.type, e.data);
        }
        
        private function run():void 
        {
            CONFIG::debug
            {
                mySound.play('01.mp3');
                
                stage.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void { mySound.play('01.mp3');} );
            }
        }
    }

}