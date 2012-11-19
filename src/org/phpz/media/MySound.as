package org.phpz.media
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundLoaderContext;
    import flash.media.SoundTransform;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    import org.phpz.media.events.AudioEvent;
    
    /**
     * ...
     * @author Seven Yu
     */
    public class MySound extends EventDispatcher
    {
        
        private var _sound:Sound;
        private var _sndChnl:SoundChannel;
        
        private var _isPaused:Boolean = false;
        private var _isPlaying:Boolean = true;
        
        private var _url:String = '';
        
        private var _vol:Number = 0.77;
        private var _pos:Number = 0;
        
        private var _pgEvtTimer:Timer;
        
        public function MySound():void
        {
        
        }
        
        override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            
            switch (type)
            {
                case AudioEvent.ON_PROGRESS: 
                {
                    _pgEvtTimer = new Timer(200);
                    _pgEvtTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                    _pgEvtTimer.start();
                    break;
                }
                default: 
                {
                    break;
                }
            }
        }
        
        private function timerHandler(e:TimerEvent):void
        {
            dispatchEvent(new AudioEvent(AudioEvent.ON_PROGRESS, {position: this.position, length: this.length}));
        }
        
        public function play(url:String, startTime:Number = 0):void
        {
            _url = url;
            
            var ur:URLRequest = new URLRequest(url);
            var lc:SoundLoaderContext = new SoundLoaderContext(1000, true);
            
            if (_sndChnl)
            {
                _sndChnl.stop();
                
                _sndChnl.removeEventListener(Event.SOUND_COMPLETE, completeHandler);
                _sound.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                
                _sndChnl = null;
                _sound = null;
            }
            
            _sound = new Sound(ur, lc);
            _sndChnl = _sound.play(startTime, 0, new SoundTransform(_vol));
            
            _sndChnl.addEventListener(Event.SOUND_COMPLETE, completeHandler);
            _sound.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            
            _isPaused = false;
            _isPlaying = true;
            
            _pos = startTime;
            
            _pgEvtTimer && _pgEvtTimer.start();
            
            dispatchEvent(new AudioEvent(AudioEvent.ON_START));
        }
        
        private function errorHandler(e:IOErrorEvent):void
        {
            trace(e);
            dispatchEvent(e);
        }
        
        private function completeHandler(e:Event):void
        {
            dispatchEvent(new AudioEvent(AudioEvent.ON_COMPLETE));
        }
        
        public function pause():void
        {
            if (!_sndChnl || !_isPlaying || _isPaused)
            {
                return;
            }
            
            _isPaused = true;
            
            _pgEvtTimer && _pgEvtTimer.stop();
            
            _pos = _sndChnl.position;
            dispatchEvent(new AudioEvent(AudioEvent.ON_PAUSE, { position: _pos } ));
            
            _sndChnl.stop();
        }
        
        public function resume():void
        {
            if (!_sndChnl || !_isPlaying || !_isPaused)
            {
                return;
            }
            
            _isPaused = false;
            
            _pgEvtTimer && _pgEvtTimer.start();
            _sndChnl = _sound.play(_pos, 0, new SoundTransform(_vol));
            dispatchEvent(new AudioEvent(AudioEvent.ON_RESUME));
        }
        
        public function stop():void
        {
            if (!_sndChnl || !_isPlaying)
            {
                return;
            }
            
            _isPlaying = false;
            
            _pgEvtTimer && _pgEvtTimer.stop();
            _pos = 0;
            _sndChnl.stop();
            dispatchEvent(new AudioEvent(AudioEvent.ON_STOP));
        }
        
        public function get url():String
        {
            return _url;
        }
        
        public function get length():Number
        {
            return _sound ? _sound.length : 0;
        }
        
        public function get position():Number
        {
            return _sndChnl ? _sndChnl.position : 0;
        }
        
        public function mute():void
        {
            dispatchEvent(new AudioEvent(AudioEvent.ON_MUTE));
            this.vol = 0;
        }
        
        public function get vol():Number
        {
            return _vol;
        }
        
        public function set vol(value:Number):void
        {
            if (!_sndChnl)
            {
                return;
            }
            _vol = value;
            _sndChnl.soundTransform = new SoundTransform(value);
            dispatchEvent(new AudioEvent(AudioEvent.ON_VOL_CHANGED, {volume: _vol}));
        }
    
    }

}