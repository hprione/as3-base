package com.hprione.players.sound.events
{
	import flash.events.Event;
	
	/**
	 * SoundPlayerEvents
	 * @author hprione
	 * @since 12/07/2010
	 */
	public class SoundPlayerEvents extends Event
	{
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		public static const COMPLETE:String = "complete";
		public static const ID3:String = "id3";
		
		public function SoundPlayerEvents (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super (type, bubbles, cancelable);
		}
		
		public override function clone ():Event
		{
			return new SoundPlayerEvents (type, bubbles, cancelable);
		} 
		
		public override function toString ():String
		{
			return formatToString ("SoundPlayerEvents", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}