package com.hprione.players.video.events
{
	import flash.events.Event;
	
	/**
	 * VideoPlayerEvents
	 * @author hprione
	 * @since 06/09/2010
	 */
	public class VideoPlayerEvents extends Event
	{
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		public static const PLAYING:String = "playing";
		public static const STREAMING:String = "playing";
		public static const STREAM_NOT_FOUND:String = "streamNotFound";
		
		public function VideoPlayerEvents (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super (type, bubbles, cancelable);
		}
		
		public override function clone ():Event
		{
			return new VideoPlayerEvents (type, bubbles, cancelable);
		} 
		
		public override function toString ():String
		{
			return formatToString ("VideoPlayerEvents", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
	
}