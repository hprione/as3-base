package com.hprione.parser
{
	import flash.events.Event;
	
	/**
	* XMLEvents
	* 
	* @author Hugo Prione
	* @since 19/11/2009
	*/
	public class XMLEvents extends Event
	{
		public static const ON_DATA:String = "onData";
		private var _data:Array;
		
		public function XMLEvents(type:String, data:Array, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		public override function clone():Event
		{
			return new XMLEvents(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String
		{
			return formatToString("XMLEvents", "data", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get data():Array { return _data; }
		
		public function set data(value:Array):void 
		{
			_data = value;
		}
	}
}