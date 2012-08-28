package org.phpz.media.events 
{
    import flash.events.Event;
    
    /**
     * ...
     * @author Seven Yu
     */
    public class AudioEvent extends Event 
    {
        
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