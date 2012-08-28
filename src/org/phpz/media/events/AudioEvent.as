package org.phpz.media.events 
{
    import flash.events.Event;
    
    /**
     * ...
     * @author Seven Yu
     */
    public class AudioEvent extends Event 
    {
        
        
        public static const ON_START:String = 'on_start';
        public static const ON_PAUSE:String = 'on_pause';
        public static const ON_RESUME:String = 'on_resume';
        public static const ON_COMPLETE:String = 'on_complete';
        public static const ON_VOL_CHANGED:String = 'on_vol_changed';
        public static const ON_MUTE:String = 'on_mute';
        
        public function AudioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
        { 
            super(type, bubbles, cancelable);
            
        } 
        
        public override function clone():Event 
        { 
            return new AudioEvent(type, bubbles, cancelable);
        } 
        
        public override function toString():String 
        { 
            return formatToString("AudioEvent", "type", "bubbles", "cancelable", "eventPhase"); 
        }
        
    }
    
}