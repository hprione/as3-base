package com.hprione.window.events
{
	import flash.events.Event;
	
	/**
	 * SequenceWindowLoaderEvents
	 * @author hprione
	 * @date 16/09/2010 14:36
	 */	
	public class SequenceWindowLoaderEvents extends Event 
	{
		public static const LOAD_WINDOW_BY_INDEX:String = "loadWindowByIndex";
		private var _index:int;
		
		public function SequenceWindowLoaderEvents (type:String, index:int, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super (type, bubbles, cancelable);
			
			this.index = index;
		} 
		
		public override function clone ():Event
		{ 
			return new SequenceWindowLoaderEvents (type, index, bubbles, cancelable);
		} 
		
		public override function toString ():String
		{ 
			return formatToString ("SequenceWindowLoaderEvents", "index", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get index ():int { return _index; }
		
		public function set index (value:int):void
		{
			_index = value;
		}
	}
}