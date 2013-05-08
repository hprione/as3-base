package com.hprione.players.video
{
	import com.hprione.players.video.events.VideoPlayerEvents;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	[Event (name = "play", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	[Event (name = "pause", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	[Event (name = "stop", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	[Event (name = "playing", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	[Event (name = "streaming", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	[Event (name = "streamNotFound", type = "com.hprione.players.video.events.VideoPlayerEvents")];
	
	/**
	 * VideoPlayer
	 * @author hprione
	 * @since 15/12/2010
	 */
	public class VideoPlayer extends Sprite
	{
		private var _connection:NetConnection;
		private var _stream:NetStream;
		private var _video:Video;
		private var _autoSize:Boolean;
		private var _duration:int;
		private var _videoURL:String;
		
		public function VideoPlayer (width:Number = 320, height:Number = 240, smoothing:Boolean = true, autoSize:Boolean = false, rtmp:String = null)
		{
			_duration = 0;
			
			_video = new Video ();
			setVideoSize (width, height);
			addChild (_video);
			
			_connection = new NetConnection ();
			_connection.addEventListener (NetStatusEvent.NET_STATUS, onNetStatus);
			_connection.client = this;
			_connection.connect (rtmp);
			
			this.smoothing = smoothing;
			this.autoSize = autoSize;
		}
		
		public function get volume ():Number
		{
			return _stream.soundTransform.volume;
		}
		
		public function set volume (value:Number):void
		{
			_stream.soundTransform = new SoundTransform (value);
		}
		
		public function get bufferTime ():Number
		{
			return _stream.bufferTime;
		}
		
		public function set bufferTime (value:Number):void
		{
			_stream.bufferTime = value;
		}
		
		public function get smoothing ():Boolean
		{
			return _video.smoothing;
		}
		
		public function set smoothing (value:Boolean):void
		{
			_video.smoothing = value;
		}
		
		public function get autoSize ():Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize (value:Boolean):void
		{
			_autoSize = value;
		}
		
		public function get position ():Number
		{
			return _stream.time;
		}
		
		private function onNetStatus (e:NetStatusEvent):void
		{
			//trace (e.info.code);
			switch (e.info.code)
			{
				case "NetConnection.Connect.Success":
					onConnect ();
					break;
				case "NetStream.Play.StreamNotFound":
					dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.STREAM_NOT_FOUND));
					break;
				case "NetStream.Play.Start":
					addEventListener (Event.ENTER_FRAME, streaming);
					_video.addEventListener (Event.ENTER_FRAME, playing);
					dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.PLAY));
					break;
				case "NetStream.Play.Stop":
					_video.removeEventListener (Event.ENTER_FRAME, playing);
					stop ();
					break;
				case "NetStream.Buffer.Flush":
					removeEventListener (Event.ENTER_FRAME, streaming);
					break;
				case "NetStream.Pause.Notify":
					_video.removeEventListener (Event.ENTER_FRAME, playing);
					break;
				default:
					trace (e.info.code);
					break;
			}
		}
		
		private function streaming (e:Event):void
		{
			dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.STREAMING));
		}
		
		private function onConnect ():void
		{
			_stream = new NetStream (_connection);
			_stream.addEventListener (NetStatusEvent.NET_STATUS, onNetStatus);
			_stream.client = this;
			
			bufferTime = 8;
			
			_video.attachNetStream (_stream);
			
			if (_videoURL)
				loadVideo (_videoURL);
		}
		
		private function setVideoSize (width:Number, height:Number):void
		{
			_video.width = width;
			_video.height = height;
			
			graphics.clear ();
			graphics.beginFill (0, 0);
			graphics.drawRect (0, 0, width, height);
			graphics.endFill ();
		}
		
		public function unload ():void
		{
			_stream.close ();
			_stream.removeEventListener (NetStatusEvent.NET_STATUS, onNetStatus);
			//_stream.client = null;
			_stream = null;
			
			_connection.close ();
			_connection.removeEventListener (NetStatusEvent.NET_STATUS, onNetStatus);
			//_connection.client = null;
			_connection = null;
		}
		
		public function onMetaData (info:Object):void
		{
			_duration = info.duration;
			
			if (autoSize)
				setVideoSize (info.width, info.height);
				
			parseInfo (info);
		}
		
		public function onXMPData (info:Object):void
		{
			parseInfo (info);
		}
		
		public function onBWDone ():void
		{
			
		}
		
		public function loadVideo (source:String):void
		{
			if (_stream)
			{
				_stream.close ();
				_stream.play (source);
			}
			else
				_videoURL = source;
		}
		
		private function playing (e:Event):void
		{
			dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.PLAYING));
		}
		
		public function play ():void
		{
			_stream.resume ();
			//_stream.play (source)
			dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.PLAY));
		}
		
		public function resume():void
		{
			_stream.resume();
		}
		
		public function pause ():void
		{
			_stream.pause ();			
			dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.PAUSE));
		}
		
		public function stop ():void
		{
			_stream.pause ();
			seek (0);
			
			dispatchEvent (new VideoPlayerEvents (VideoPlayerEvents.STOP));
		}
		
		public function seek (percentage:Number):void
		{
			_stream.seek (percentage * _duration);
		}
		
		public function getPercentPosition ():Number
		{
			if (!_stream)
				return 0;
				
			if (_duration < _stream.time)
				return 0;
				
			return _stream.time / _duration;
		}
		
		public function getPercentLoaded ():Number
		{
			return _stream.bytesLoaded / _stream.bytesTotal;
		}
		
		public function onPlayStatus (info:Object):void
		{
			if (info.code == "NetStream.Play.Complete")
			{
				_video.removeEventListener (Event.ENTER_FRAME, playing);
				stop ();
			}
			
			parseInfo (info);
		}
		
		private function parseInfo (info:Object):void
		{
			/*
			 * for debug purposes only
			*/
			
			/*
			trace ("***********************************");
			trace ("VIDEO METADATA");
			for (var i:String in info)
				trace (i, info[i]);
			trace ("***********************************");
			//*/
		}
	}
}