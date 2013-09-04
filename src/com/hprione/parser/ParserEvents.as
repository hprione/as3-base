package com.hprione.parser
{
	import flash.events.Event;
	
	/**
	 * @author hprione
	 * @since 27/05/2013
	 */
	public class ParserEvents extends Event 
	{
		public static const ON_DATA:String = "onData";
		
		private var _data:Object;
		
		public function ParserEvents(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
		}
		
		public override function clone():Event
		{
			return new ParserEvents(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("ParserEvents", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}