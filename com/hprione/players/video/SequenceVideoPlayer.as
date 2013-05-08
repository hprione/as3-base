package com.hprione.players.video
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * SequenceVideoPlayer
	 * @author hprione
	 * @since 05/08/2010
	 */
	public class SequenceVideoPlayer extends VideoPlayer
	{
		private var _sequence:Vector.<String>;
		private var _index:int;
		
		public function SequenceVideoPlayer (width:Number = 320, height:Number = 240, smoothing:Boolean = true, autoSize:Boolean = false, rtmp:String = null)
		{
			super (width, height, smoothing, autoSize, rtmp);
			
			removeAll ();
		}
		
		public function addSequenceVideo (first:String, last:String):void
		{
			var _prefixe:String = first.replace(/(.*)\d+/,"$1");
			var _sequence:int = int(first.replace(/.*(\d+)/,"$1"));
			var _current:String = first;
			
			addVideo (_current);
			while (_current != last)
				addVideo (_current = _prefixe + (++_sequence).toString ());
		}
		
		public function addVideo (url:String):void
		{
			_sequence.push (url);
		}
		
		public function removeVideo (url:String):void
		{
			var _pos:int = _sequence.indexOf (url);
			
			if (_pos > -1)
				_sequence.splice (_pos, 1);
		}
		
		public function removeAll ():void
		{
			_sequence = new Vector.<String>();
			_index = 0;
		}
		
		public function loadByIndex (index:int):void
		{
			loadVideo (_sequence[_index = index]);
			play ();
		}
		
		public function loadFirst ():void
		{
			loadVideo (_sequence[_index = 0]);
			play ();
		}
		
		public function loadNext ():void
		{
			if (!hasNext ())
				return;
				
			loadVideo (_sequence[++_index]);
			play ();
		}
		
		public function loadPrev ():void
		{
			if (!hasPrev ())
				return;
				
			loadVideo (_sequence[--_index]);
			play ();
		}
		
		public function hasNext ():Boolean
		{
			return (_index + 1) < _sequence.length;
		}
		
		public function hasPrev ():Boolean
		{
			return (_index - 1) > -1;
		}		
	}
}