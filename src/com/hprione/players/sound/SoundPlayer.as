package com.hprione.players.sound
{
	import com.hprione.players.sound.events.SoundPlayerEvents;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * SoundPlayer
	 * @author hprione
	 * @since 05/08/2010
	 */
	[Event (name = "play", type = "com.hprione.players.sound.events.SoundPlayerEvents")];
	[Event (name = "pause", type = "com.hprione.players.sound.events.SoundPlayerEvents")];
	[Event (name = "stop", type = "com.hprione.players.sound.events.SoundPlayerEvents")];
	[Event(name = "complete", type = "com.hprione.players.sound.events.SoundPlayerEvents")];
	[Event (name = "id3", type = "com.hprione.players.sound.events.SoundPlayerEvents")];
	public class SoundPlayer extends EventDispatcher
	{
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _position:int;
		private var _volume:Number;
		private var _repeat:Boolean;
		
		public function SoundPlayer (url:URLRequest = null, volume:Number = 1)
		{
			this.volume = volume;
			
			if (url)
				load (url);
		}
		
		protected function onSoundComplete (e:Event):void
		{
			if (repeat)
			{
				_position = 0;
				play ();
			}
			
			dispatchEvent(new SoundPlayerEvents(SoundPlayerEvents.COMPLETE));
		}
		
		private function onId3 (e:Event):void
		{
			dispatchEvent (new SoundPlayerEvents (SoundPlayerEvents.ID3));
		}
		
		public function load (url:URLRequest):void
		{
			if (_sound)
			{
				_sound.removeEventListener (Event.ID3, onId3);
				_sound = null;
			}
			
			_sound = new Sound (url, new SoundLoaderContext (5000));
			_sound.addEventListener (Event.ID3, onId3);
		}
		
		public function play ():void
		{
			if (_channel)
			{
				_channel.stop ();
				_channel.removeEventListener (Event.SOUND_COMPLETE, onSoundComplete);
				_channel = null;
			}
			
			_channel = _sound.play (_position);
			_channel.addEventListener (Event.SOUND_COMPLETE, onSoundComplete);
			_channel.soundTransform = new SoundTransform (volume);
			
			dispatchEvent (new SoundPlayerEvents (SoundPlayerEvents.PLAY));
		}
		
		public function pause ():void
		{
			_position = _channel.position;
			_channel.stop ();
			
			dispatchEvent (new SoundPlayerEvents (SoundPlayerEvents.PAUSE));
		}
		
		public function stop ():void
		{
			_position = 0;
			
			if (_channel)
				_channel.stop ();
				
			dispatchEvent (new SoundPlayerEvents (SoundPlayerEvents.STOP));
		}
		
		public function seek (perc:Number):void
		{
			stop ();
			_position = (perc / 100) * _sound.length;
			play ();
		}
		
		public function get volume ():Number { return _volume; }
		
		public function set volume (value:Number):void
		{
			if (value < 0)
				value = 0;
				
			if (value == _volume)
				return;
				
			_volume = value;
			
			if (_channel)
				_channel.soundTransform = new SoundTransform (value);
		}
		
		public function get repeat ():Boolean { return _repeat; }
		
		public function set repeat (value:Boolean):void
		{
			_repeat = value;
		}
		
		public function get id3 ():ID3Info
		{
			return _sound.id3;
		}
		
		public function get position():Number
		{
			return _channel.position / _sound.length;
		}
	}
}