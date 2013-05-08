package com.hprione.players.sound
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * SequenceSoundPlayer
	 * @author hprione
	 * @since 05/08/2010
	 */
	//TODO implement the shuffle function
	//TODO unify the sequences classes
	public class SequenceSoundPlayer extends SoundPlayer
	{
		private var _sequence:Vector.<String>;
		private var _index:int;
		private var _repeatAll:Boolean;
		
		public function SequenceSoundPlayer (volume:Number = 1):void
		{
			super (null, volume);
			
			removeAll ();
		}
		
		override protected function onSoundComplete (e:Event):void
		{
			super.onSoundComplete (e);
			
			if (repeatAll)
				loadNext ();
		}
		
		public function addSequenceSound (first:String, last:String):void
		{
			var _prefixe:String = first.replace(/(.*)\d+/,"$1");
			var _sequence:int = int(first.replace(/.*(\d+)/,"$1"));
			var _current:String = first;
			
			addSound (_current);
			while (_current != last)
				addSound (_current = _prefixe + (++_sequence).toString ());
		}
		
		public function addSound (url:String):void
		{
			_sequence.push (url);
		}
		
		public function removeSound (url:String):void
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
			stop ();
			load (new URLRequest (_sequence[_index = index]));
			play ();
		}
		
		public function loadFirst ():void
		{
			stop ();
			load (new URLRequest (_sequence[_index = 0]));
			play ();
		}
		
		public function loadNext ():void
		{
			if (!hasNext ())
				return;
				
			if (++_index > _sequence.length - 1)
				_index = 0;
				
			stop ();
			load (new URLRequest (_sequence[_index]));
			play ();
		}
		
		public function loadPrev ():void
		{
			if (!hasPrev ())
				return;
				
			if (--_index < 0)
				_index = _sequence.length - 1;
				
			stop ();
			load (new URLRequest (_sequence[_index]));
			play ();
		}
		
		public function hasNext ():Boolean
		{
			var has:Boolean;
			
			if (repeatAll)
				has = true;
			else
				has = (_index + 1) < _sequence.length;
			return has;
		}
		
		public function hasPrev ():Boolean
		{
			var has:Boolean;
			
			if (repeatAll)
				has = true;
			else
				has = (_index - 1) > -1;
			return has;
		}
		
		public function get repeatAll ():Boolean { return _repeatAll; }
		
		public function set repeatAll (value:Boolean):void
		{
			_repeatAll = value;
			
			if (value)
				repeat = false;
		}
	}
}